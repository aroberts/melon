require 'optparse'
require 'melon/parsed_arguments'
require 'melon/commands'

module Melon
  class CLI
    def self.execute(arguments=[])
      new(arguments).run
    end

    attr_accessor :options, :parsed_arguments

    def initialize(arguments)
      self.options = {
        # TODO: externalize defaults
        :database => '~/.melon/melon.db'
      }
      # TODO: read .melonrc here, feed into options

      self.parsed_arguments = ParsedArguments.new(arguments)
    end

    def run
      begin
        parser.parse!(parsed_arguments.program_arguments)
      rescue OptionParser::InvalidOption => e
        puts "melon: #{e.to_s}"
        exit 1
      end

      # puts "Using database: #{options[:database]}"
      if parsed_arguments.command.nil?
        if parsed_arguments.program_arguments.empty?
          usage
        else
          puts "melon: '#{parsed_arguments.program_arguments.shift}'" +
            " is not a recognized command." 
          exit 1;
        end
      end

      # find the command
      command = Melon::Commands.translate_command(parsed_arguments.command)
      if command == Melon::Commands::Help && 
        # special case for help with no args - passing usage inside of 
        # help is a pain, so we'll do it here
        parsed_arguments.command_arguments.empty?
        usage
      else
        # run the command with the command arguments
        command.execute(parsed_arguments.command_arguments, options)
      end
    end

    def parser
      @parser ||= OptionParser.new do |opts|
        opts.banner = <<-BANNER.gsub(/^          /,'')
          Usage: #{File.basename($0)} [options] COMMAND [command-options] [ARGS]

          Options are:
        BANNER
        opts.on("-d", "--database=PATH", String,
                "Path to Melon's sqlite database.",
                "  (default ~/.melon/melon.db)") do |arg|
          self.options[:database] = arg
                end
    
        opts.on("-v", "--version",
                "Display the program version.") { version }
        opts.on("-h", "--help",
                "Show this help message.") { usage }
        opts.separator ""
        opts.separator "Commands"
        
        Melon::Commands.command_constants.each do |command|
          opts.separator "   #{command.short_usage}" if command.short_usage
        end

        opts.separator ""
        opts.separator "To get help with a specific command," +
          " use 'melon help COMMAND'"
      end
    end

    def version
      puts "melon version #{Melon::VERSION}"
      exit
    end

    def usage
      puts parser
      exit
    end
  end
end
