require 'optparse'

module Melon
  class CLI

    attr_accessor :options, :parsed_arguments

    def self.commands
      %w(help)
    end

    def self.execute(arguments=[])
      new(arguments).run
    end

    def self.split_arguments(arguments)

      [arguments, arguments, arguments]
    end

    def initialize(arguments)
      self.options = {
        :database => '~/.melon/melon.db'
      }

      self.parsed_arguments = ParsedArguments.new(arguments)
    end

    def run
      parser.parse!(program_args)
      # do stuff
      stdout.puts "Using database: #{options[:database]}"
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
    
        opts.on("-h", "--help",
                "Show this help message.") { puts parser; exit }
        opts.separator ""
        opts.separator "Commands"
        
        self.commands.each do |command|
          # TODO banner for each command
          opts.separator
        end
      end
    end
  end
end
