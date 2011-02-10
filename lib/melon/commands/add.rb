require 'melon/hasher'
require 'melon/commands/base'
require 'melon/commands/common_options'

module Melon
  module Commands
    class Add < Base
      def self.description
        "Add files to the melon database"
      end

      def parser_options(parser)
        parser.on("-q", "--quiet", "Suppress printing of hash and path") do
          options.quiet = true
        end

        CommonOptions.recursive(parser, options)

        parser.on("-u", "--update", 
                  "Skip paths already present in the database") do
          options.update = true
        end

        CommonOptions.preserve_symlinks(parser, options)
      end

      def usageargs
        "FILE [FILE [FILE ...]"
      end

      def run
        parse_options!

        if options.recursive
          self.args = recursively_expand(args)
        end

        options.database.transaction do
          args.each do |arg|
            filename = File.expand_path(arg)

            if File.directory?(filename)
              error "argument is a directory: #{arg}"
            end

            if options.database[:by_path][filename]
              next if options.update
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
  end
end
