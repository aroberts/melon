require 'melon/commands/base'

module Melon
  module Commands
    class List < Base
      def self.description
        "List the files tracked by the database"
      end

      def parser_options(parser)
          parser.on("-p", "--paths", "Print only paths") do
            options.only_paths = true
          end
          # TODO: re-enable this as -h after help command goes in
          parser.on("-c", "--checksums", "print only hashes") do
            options.only_hashes = true 
          end
      end

      def verify_args
        error "invalid argument: #{args.shift}" unless args.empty?
      end

      def run
        parse_options!

        options.database.transaction do
          options.database[:by_hash].each_pair do |hash, path|
            out = [path, hash]
            out.delete(path) if options.only_hashes
            out.delete(hash) if options.only_paths
            puts out.join(":")
          end
        end
      end
    end
  end
end
