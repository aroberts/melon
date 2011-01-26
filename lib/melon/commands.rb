require 'pstore'
require 'ftools'

require 'melon/hasher'
require 'melon/helpers'

module Melon
  module Commands
    def self.each
      consts = []
      base = self.const_get('Base')
      self.constants.each do |c|
        const = self.const_get(c)
        if const.superclass == base
          consts << const
          yield const 
        end
      end
      consts
    end

    class << self
      alias :[] :const_get
    end
    # needs a 'verify' command to check integrity of database
    #   both internal 2-hash consistency (consistency) and db<->filesystem
    #   matching up (integrity) [file exists, hashes match]
    # needs a 'remove' command, or some way to deal with deletes/renames
    # needs a 'list' command
    class Base
      include Helpers
      attr_accessor :args, :options
      attr_reader :description

      def initialize(args, options)
        self.args = args
        self.options = options
      end

      def parser
        raise
      end

      def self.description
        raise
      end

      def parse_options!
        begin
          parser.parse!(args)
        rescue OptionParser::ParseError => e
          error "#{self.class.to_s.split("::").last.downcase}: #{e}"
        end
      end

    end

    class Add < Base

      def self.description
        "Add files to the melon database"
      end

      def parser
        @parser ||= OptionParser.new do |p|
          p.banner = "Usage: melon add [options] file [file [file ...]]"
          p.separator ""
          p.separator Add.description

          p.separator ""
          p.separator "Options:"
          p.separator ""

          p.on("-q", "--quiet", "Suppress printing of hash and path") do
            options.quiet = true
          end

          # p.on("-f", "--force",
          #      "Force the recalculation of the path that",
          #      " already exists in the database") do
          #   options.force = true
          #      end
        end
      end

      def run
        parse_options!

        options.database.transaction do
          args.each do |arg|
            filename = File.expand_path(arg)

            if File.directory?(filename)
              error "argument is a directory: #{arg}"
            end

            if options.database[:by_path][filename]# and !options.force
              error "path already present in database: #{arg}"
            end

            # hash strategy should be encapsulated, ergo indirection here
            hash = Hasher.digest(filename)

            if options.database[:by_hash][hash]
              error "file exists elsewhere in the database: #{arg}"
            end


            options.database[:by_hash][hash] = filename
            options.database[:by_path][filename] = hash
            puts "#{hash}:#{filename}" unless options.quiet
          end
        end
      end
    end

    class Check < Base
      def self.description
        "Determine whether or not a copy of a file resides in the database"
      end

      def parser
        @parser ||= OptionParser.new do |p|
          p.banner = "Usage: melon check file [file [file ...]]"
          p.separator ""
          p.separator Check.description
        end
      end

      def run
        parse_options!

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
