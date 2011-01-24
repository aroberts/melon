require 'rubygems'
require 'subcommand'

require 'melon/version'

module Melon
  class CLI
    def self.execute(arguments=[])
      new(arguments).run
    end

    attr_accessor :arguments

    def initialize(arguments)
      self.arguments = arguments
    end

    def run
      # command may be nil, if no command is given
      command = parser.parse!(arguments)
    end

    def parser
      @parser ||= OptionParser.new do |opts|
        opts.banner = "Example of what option parsing should look like"

        opts.on("-d", "--database=PATH", String,
                "Path to Melon's sqlite database.",
                "  (default ~/.melon/melon.db)") do |arg|
          self.options[:database] = arg
                end
    
        opts.on("-v", "--version",
                "Display the program version.") { puts "0.0.0" }
        opts.on("-h", "--help",
                "Show this help message.") { puts parser }
        opts.separator ""

        opts.command :create, "description text" do |subopts|
          subopts.banner "create: create a directory, somewhere"

          subopts.on("-f" "--force",
                     "Force creation.") { self.options[:force] = true }
        end


        opts.separator "To see a list of commands, use 'melon help commands'."
        opts.separator "To get help with a specific command," +
          " use 'melon help COMMAND'."
      end

      # OptionParser#command adds lazy option parsers to an array
      # of subcommands
      #
      # melon help COMMAND prints the appropriate option
      #
      # PARSING:
      # the option parser knows what the commands are at parse time
      # so, scan the parse!() argument for the first command and pivot on
      # it
      #
      # pre-cmd goes to the main option_parser.parse
      # cmd goes into a string, is returned
      # post-cmd goes to cmd parser.parse!()
      #
      # possibly implement that behavior for order! as well 
  end
end
