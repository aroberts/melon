require 'melon/commands/basic_command'
require 'sqlite3'


module Melon
  module Commands
    class Init
      extend BasicCommand

      def self.description
        "Initialize the melon database"
      end

      attr_accessor :arguments, :database

      def initialize(arguments, options)
        self.arguments = arguments
      end

      def parser
        @parser ||= OptionParser.new do |opts|
          # opts.
          # TODO: Banner
          # TODO: does sqlite3::database.new clobber files? irb
        end
      end

      def run
        begin
          parser.parse!(arguments)
        rescue OptionParser::InvalidOption => e
          puts "melon: #{e.to_s}"
          exit 1
        end


        self.database = SQLite3::Database.new(options[:database])
      end

    end
  end
end

