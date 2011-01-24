require 'pstore'
require 'ftools'

require 'melon/hasher'
require 'melon/cli'

module Melon
  module Commands
    # needs a 'verify' command to check integrity of database
    # needs a 'remove' command, or some way to deal with deletes/renames
    class Add
      # TODO force option
      # TODO don't allow overwrites
      attr_accessor :args, :options

      def initialize(args, options)
        self.args = args
        self.options = options
      end

      def run
        options.database.transaction do
          args.each do |filename|
            # puts "Adding #{filename}..."

            # hash strategy should be encapsulated, ergo indirection here
            hash = Hasher.digest(filename)

            absolute_path = File.expand_path(filename)

            if options.database[:by_path][absolute_path]:
              CLI.error "path already present in database"
            end

            options.database[:by_hash][hash] = absolute_path
            options.database[:by_path][absolute_path] = hash
            puts "#{hash}:#{absolute_path}"
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
        puts "in check"
      end
    end
  end
end
