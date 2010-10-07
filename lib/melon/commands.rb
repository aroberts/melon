require 'melon/commands/help'
# Dir[File.dirname(__FILE__) + 'commands/*.rb'].each do |file| 
#   raise File.basename(file, File.extname(file))
# end

module Melon
  module Commands

    def self.command_constants
      # TODO: can I just write the classname and prefix the modules?
      @@command_constants ||= [
        Melon::Commands::Help,
      ]
    end

    def self.command_hash
      @@command_hash ||= Hash[
        *command_constants.collect do |c|
          [translate_command(c), c]
        end.flatten]
    end

    def self.commands
      @@commands ||= command_hash.keys
    end

    def self.translate_command(clazz_or_string)
      if clazz_or_string.is_a? Class
        if command_constants.include? clazz_or_string
          clazz_or_string.to_s.split("::")[-1].downcase
        end
      else
        command_hash[clazz_or_string]
      end || raise(ArgumentError, "'#{clazz_or_string}' is not a valid command.")
    end
  end
end
