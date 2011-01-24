require 'pstore'
require 'ftools'

require 'melon/hasher'

module Melon
  module Commands
    # needs a 'verify' command to check integrity of database
    class Add
      attr_accessor :args, :options

      def initialize(args, options)
        self.args = args
        self.options = options
      end

      def run
        options.database.transaction do
          args.each do |filename|
            puts "Adding #{filename}..."

            # hash strategy should be encapsulated, ergo indirection here
            hash = Hasher.digest(filename)

            absolute_path = File.expand_path(filename)

            options.database[hash] = absolute_path
            puts "#{hash}:#{absolute_path}"
            exit 0
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
