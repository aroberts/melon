require 'melon/commands/base'

module Melon
  module Commands
    class Show < Base
      def self.description
        "Show where the database thinks a file is located"
      end

      def usageargs
        "FILE [FILE [FILE ...]"
      end

      def helptext
        <<EOS
  If the file's hash matches a hash in the database, then
the associated path in the database is printed.  Otherwise,
nothing is printed.
EOS
      end

      def run
        parse_options!

        options.database.transaction do
          args.each do |filename|
            hash = Hasher.digest(filename)
            if path = options.database[:by_hash][hash]
              puts path
            end
          end
        end
      end
    end
  end
end
