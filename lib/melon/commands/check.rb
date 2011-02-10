require 'melon/commands/base'
require 'melon/commands/common_options'

module Melon
  module Commands
    class Check < Base
      def self.description
        "Determine whether or not a copy of a file resides in the database"
      end

      def helptext
        <<EOS
If the file's hash matches a hash in the database, nothing is
printed.  Otherwise, the full path to the file is printed.
EOS
      end

      def usageargs
        "FILE [FILE [FILE ...]]"
      end

      def parser_options(parser)
        CommonOptions.recursive(parser, options)
        CommonOptions.preserve_symlinks(parser, options)
      end

      def run
        parse_options!

        if options.recursive
          self.args = recursively_expand(args)
        end

        options.database.transaction do
          args.each do |arg|
            filename = File.expand_path(arg)
            filename = resolve_symlinks(filename) unless options.preserve_symlinks

            if File.directory?(filename)
              error "argument is a directory: #{arg}"
            end

            hash = Hasher.digest(filename)
            unless options.database[:by_hash][hash]
              puts filename
            end
          end
        end
      end
    end
  end
end
