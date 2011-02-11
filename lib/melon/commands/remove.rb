require 'melon/commands/base'
require 'melon/commands/common_options'

module Melon
  module Commands
    class Remove < Base
      def self.description
        "Remove a file from the database"
      end

      def helptext
        <<EOS
For each argument, the database is checked for the path of that
argument.  If present, it is removed.  If not, the database is
checked for the hash of the argument.  Once again, the record
in the database is removed if found.

 If a file is found, the path that was in the database is printed.
EOS
      end

      def usageargs
        "FILE [FILE [FILE ...]]"
      end

      def parser_options(parser)
        CommonOptions.recursive(parser, options)
      end

      def run
        parse_options!

        if options.recursive
          self.args = recursively_expand(args)
        end

        options.database.transaction do
          args.each do |arg|
            filename = File.expand_path(arg)
            filename = resolve_symlinks(filename)

            if File.directory?(filename)
              error "argument is a directory: #{arg}"
            end

            if options.database[:by_path][filename]
              hash = options.database[:by_path].delete(filename)
              options.database[:by_hash].delete(hash)
              puts filename
            else
              hash = Hasher.digest(filename)
              if options.database[:by_hash][hash]
                filename = options.database[:by_hash].delete(hash)
                options.database[:by_path].delete(filename)
                puts filename
              else
                error("untracked file: #{arg}")
              end
            end
          end
        end
      end
    end
  end
end
