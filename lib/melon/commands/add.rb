require 'melon/hasher'
require 'melon/commands/base'

module Melon
  module Commands
    class Add < Base
      def self.description
        "Add files to the melon database"
      end

      def parser
        @parser ||= OptionParser.new do |p|
          p.banner = "Usage: melon add [options] file [file [file ...]]"
          p.separator ""
          p.separator blockquote(Add.description + ".")

          p.separator ""
          p.separator "Options:"
          p.separator ""

          p.on("-q", "--quiet", "Suppress printing of hash and path") do
            options.quiet = true
          end

          p.on("-r", "--recursive", "Recursively add directory contents") do
            options.recursive = true
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

        if options.recursive
          self.args = args.collect do |arg|
            if File.directory?(arg)
              Dir["#{arg}/**/*"]
            else
              arg
            end
          end.flatten.reject { |arg| File.directory?(arg) }
        end

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
  end
end
