require 'pstore'
require 'ftools'

require 'melon/hasher'
require 'melon/cli'

# TODO: in commands, parse arguments with parse!  in CLI, parse with order!

module Melon
  module Commands
    # needs a 'verify' command to check integrity of database
    # needs a 'remove' command, or some way to deal with deletes/renames
    class Base
      attr_accessor :args, :options
      attr_reader :description

      def initialize(args, options)
        self.args = args
        self.options = options
      end

      def parser
        raise
      end

      def description
        raise
      end

      def parse_options!
        begin
          parser.parse!(args)
        rescue OptionParser::ParseError => e
          CLI.error "#{self.class.to_s.split("::").last.downcase}: #{e}"
        end
      end

    end

    class Add < Base

      def description
        "Add files to the melon database"
      end

      def parser
        @parser ||= OptionParser.new do |p|
          p.banner = "Usage: melon add file [file [file ...]]"
          p.separator ""
          p.separator description

          p.separator ""
          p.separator "Options:"
          p.separator ""

          p.on("-f", "--force",
               "Add a file even if it already exists, overwriting",
               "any previously stored data") do
            options.force = true
               end
        end
      end

      def run
        parse_options!

        options.database.transaction do
          args.each do |filename|
            # puts "Adding #{filename}..."

            # hash strategy should be encapsulated, ergo indirection here
            hash = Hasher.digest(filename)

            filename = File.expand_path(filename)
            if File.directory?(filename)
              CLI.error "argument is a directory: #{filename}"
            end

            if options.database[:by_path][filename] and !options.force
              CLI.error "path already present in database"
            end

            options.database[:by_hash][hash] = filename
            options.database[:by_path][filename] = hash
            puts "#{hash}:#{filename}"
          end
        end
      end
    end

    class Check
      attr_accessor :args, :options

      def initialize(args, options)
        self.args = args
        self.options = options
      end

      def run
        options.database.transaction do
          args.each do |filename|
            hash = Hasher.digest(filename)
            unless options.database[:by_hash][hash]
              puts File.expand_path(filename)
            end
          end
        end
      end
    end
  end
end
