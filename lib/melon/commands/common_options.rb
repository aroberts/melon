module Melon
  module Commands
    module CommonOptions
      def self.recursive(parser, options)
        parser.on("-r", "--recursive", "Recursively process directories") do
          options.recursive = true
        end
      end

      def self.preserve_symlinks(parser, options)
        parser.on("-p", "--preserve-symlinks", "Don't expand symlinks") do
          options.preserve_symlinks = true
        end
      end
    end
  end
end
