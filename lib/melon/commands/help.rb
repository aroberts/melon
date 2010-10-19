require 'melon/commands/basic_command'

module Melon
  module Commands
    class Help
      # Help is a basic command that also ties itself in to cli#usage, so
      # it's a little bit unconventional.  Retrospectively, I should not
      # have written it first.  
      extend BasicCommand

      def self.description
        "Get help with a specific command, or with Melon in general"
      end

      attr_accessor :arguments

      def initialize(arguments, options)
        self.arguments = arguments
      end
      
      def parser
        @parser ||= OptionParser.new do |opts|
          Melon::Commands.command_hash.each do |name, command|
            next if command == self.class
            # TODO help banner: gem help help
            # TODO flesh out parsing - give short_usage for each command
            opts.on(name) { command.parser }
          end
        end
      end

      def run
        begin
          parser.parse!(arguments)
        rescue OptionParser::InvalidOption => e
          puts "melon: #{e.to_s}"
          exit 1
        end

        if arguments == ['help']
          puts parser
          exit
        end
        
        # if arguments are empty, we handled it in CLI
        puts "melon: '#{arguments.join(' ')}' is not a recognized command."
        exit 1
      end
    end
  end
end
