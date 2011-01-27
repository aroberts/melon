require 'melon/commands/base'

module Melon
  module Commands
    class List < Base
      def self.description
        "List the files tracked by the database"
      end

      def parser
        @parser ||= OptionParser.new do |p|
          p.banner = "Usage: melon list [options]"
          p.separator ""
          p.separator blockquote(self.class.description)

          p.separator ""
          p.separator "Options:"
          p.separator ""

          p.on("-p", "--paths", "print only paths") do
            options.only_paths = true
          end
          # TODO: re-enable this as -h after help command goes in
          # p.on("--hashes", "print only hashes") { options.only_hashes = true }
          
        end
      end

      def verify_args
        error "invalid argument: #{args.shift}" unless args.empty?
      end

      def run
        parse_options!

        options.database.transaction do
          options.database[:by_hash].each_pair do |hash, path|
            puts "#{path}:#{hash}"
          end
        end
      end
    end
  end
end
