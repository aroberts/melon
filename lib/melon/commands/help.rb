require 'melon/commands/base'

module Melon
  module Commands
    class Help < Base
      def self.description
        "Get help with a specific command"
      end
    end
  end
end
