require 'ostruct'
require 'optparse'

require 'melon/version'
require 'melon/commands'

module Melon
  class CLI

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

      unless arguments.empty?
        run_command(options)
      end
    end

    def run_command(options)
      # look for command class in args.shift
      command_name = arguments.shift
      begin
        command = Commands.const_get(command_name.capitalize)
        command.new(arguments, options).run
      # rescue NameError
      #   CLI.error "unrecognized command: #{command_name}"
      end
    end

    def parse_options
      options = CLI.default_options

      parser = OptionParser.new do |p|
        p.banner = "Usage: melon [options] COMMAND [command-options] [ARGS]"

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
        parser.parse!(arguments)
      rescue OptionParser::ParseError => e
        CLI.error e
      end

      options
    end
    
    def self.error(error_obj_or_str, code = 1)
      if error_obj_or_str.respond_to?('to_s')
        error_str = error_obj_or_str.to_s
      else
        error_str = error_obj_or_str.inspect
      end

      $stderr.puts "melon: #{error_str}"
      exit code
    end
  end
end
