module Melon
  module Commands
    module BasicCommand

      def execute(arguments, options)
        new(arguments, options).run
      end

      # returns name {padding} description, for usage"
      def short_usage(padding="   ")
        name = Melon::Commands.translate_command(self)
        extra_spaces = Melon::Commands.commands.collect do |c|
          c.length
        end.max - name.length
        "#{name}#{padding}#{' ' * extra_spaces}#{self.description}"
      end
    end
  end
end
