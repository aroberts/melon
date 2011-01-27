require 'ostruct'
require 'pstore'
require 'optparse'

require 'melon/version'
require 'melon/commands'
require 'melon/helpers'

module Melon
  class CLI
    include Helpers

    def self.execute(arguments=[])
      new(arguments).run
    end

    attr_accessor :arguments

    def initialize(arguments)
      self.arguments = arguments
    end

    def self.default_options
      options = OpenStruct.new
      options.database_path = "#{ENV['HOME']}/.melondb"
      options
    end    

    def run
      options = parse_options
      options.database = PStore.new(File.expand_path(options.database_path))

      # prepare db
      options.database.transaction do
        options.database[:by_hash] ||= {}
        options.database[:by_path] ||= {}
      end

      unless arguments.empty?
        run_command(options)
      end
    end

    def run_command(options)
      # look for command class in args.shift
      command_name = arguments.shift
      begin
        c = Commands[command_name.capitalize]
      rescue NameError => e
        # don't swallow NoMethodErrors
        raise e unless e.instance_of?(NameError)
        error "unrecognized command: #{command_name}"
      end
      c.new(arguments, options).run
    end

    def parse_options
      options = self.class.default_options

      # TODO: -q option, gags stdout (not stderr)

      parser = OptionParser.new do |p|
        p.banner = "Usage: melon [options] COMMAND [command-options] [ARGS]"

        p.separator ""
        p.separator "Commands:"
        p.separator ""

        %w(add check).each do |command|
          cls = Commands.const_get(command.capitalize)
          p.separator format_command(command, cls.description)
        end

        p.separator ""
        p.separator "Options:"
        p.separator ""

        p.on("-d", "--database PATH",
             "Path to database file (#{options.database_path})") do |database|
          options.database_path = database
             end

        p.on_tail("-v", "--version", "Show version") do
          puts Melon.version_string
          exit 0
        end

        p.on_tail("-h", "--help", "This is it") do
          puts p
          exit 0
        end
      end

      begin
        parser.order!(arguments)
      rescue OptionParser::ParseError => e
        error e
      end

      options
    end
  end
end
