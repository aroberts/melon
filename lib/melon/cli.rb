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

    attr_accessor :arguments, :options, :parser 

    def initialize(arguments)
      self.arguments = arguments
    end

    def self.default_options
      options = OpenStruct.new
      options.database_path = "#{ENV['HOME']}/.melondb"
      options
    end    

    def parser
      @parser ||= OptionParser.new do |p|
        p.banner = "Usage: melon [options] COMMAND [command-options] [ARGS]"

        p.separator ""
        p.separator "Commands:"
        p.separator ""

        Commands.each do |command|
          if command.command_name == 'help'
            next
          end

          p.separator format_command(command.command_name,
                                     command.description)
        end
        p.separator ""
        p.separator "Options:"
        p.separator ""

        p.on("-d", "--database PATH",
             "Path to database file (#{options.database_path})") do |database|
          options.database_path = database
             end

        p.on("-v", "--version", "Show version") do
          puts Melon.version_string
          exit 0
        end

        p.on("-h", "--help", "This is it") do
          puts p
          exit 0
        end

        p.separator ""
        p.separator "For more information on a specific command," +
          " use 'melon help COMMAND'"
      end

    end

    def run
      parse_options
      options.database = PStore.new(File.expand_path(options.database_path))

      # prepare db
      options.database.transaction do
        options.database[:by_hash] ||= {}
        options.database[:by_path] ||= {}
      end

      if arguments.empty?
        puts parser
        exit
      else
        # look for command class in args.shift
        command_name = arguments.shift

        run_command(command_name)
      end
    end

    def run_command(command_name)
      begin
        command_class = Commands[command_name.capitalize]
      rescue NameError => e
        # don't swallow NoMethodErrors
        raise e unless e.instance_of?(NameError)
        error "unrecognized command: #{command_name}"
      end
      c = command_class.new(arguments, options)
      (command_name == 'help' ? c.run(self) : c.run)
    end

    def parse_options
      self.options = self.class.default_options

      # TODO: empty args should be -h

      begin
        parser.order!(arguments)
      rescue OptionParser::ParseError => e
        error e
      end

      options
    end
  end
end
