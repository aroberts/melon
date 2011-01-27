require 'melon/commands/base'

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
        "file [file [file ...]"
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
