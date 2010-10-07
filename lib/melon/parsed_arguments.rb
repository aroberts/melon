require 'melon/commands'

module Melon
  class ParsedArguments

    attr_reader :program_arguments, :command, :command_arguments

    def initialize(list)
      # take the first command we find
      command_index = Melon::Commands.commands.collect do |c|
        list.index(c)
      end.reject { |i| i.nil? }.min

      if command_index.nil?
        @program_arguments = list
        @command = nil
        @command_arguments = nil
      else
        @program_arguments = list[0...command_index]
        @command = list[command_index]
        @command_arguments = list[command_index+1...list.length]
      end
    end
  end
end
