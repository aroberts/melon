require 'melon/commands/base'
require 'melon/commands'

module Melon
  module Commands
    class Help < Base
      def self.description
        "Get help with a specific command"
      end

      def run
        help = args.shift
        begin
          puts Commands[help.capitalize].new(args, options).parser
        rescue NameError => e
          # don't swallow NoMethodErrors
          raise e unless e.instance_of?(NameError)
          error "unrecognized command: #{help}"
        end
      end
    end
  end
end
