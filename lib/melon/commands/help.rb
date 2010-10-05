module Melon
  module Commands
    class Help < Command
      #TODO port this all up to command
      def self.execute(arguments, program_options)
        new(arguments, program_options).run
      end

      def self.description
        "Get help with a specific command, or with Melon in general"
      end

      # returns name {padding} description, for usage"
      def self.short_usage_string(padding="")
        "#{self.class.name.lower} #{padding} #{self.description}"
      end

      # todo: basically, this command takes another command, and then
      # prints its parser.
    end
  end
end
