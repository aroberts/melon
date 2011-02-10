require 'optparse'
require 'melon/helpers'

module Melon
  module Commands
    class Base
      include Helpers
      attr_accessor :args, :options
      attr_reader :description

      def initialize(args, options)
        self.args = args
        self.options = options
      end

      def self.command_name
        self.to_s.split("::")[-1].downcase
      end

      def parser
        @parser ||= OptionParser.new do |p|
          p.banner = usagebanner
          p.separator ""
          p.separator blockquote(self.class.description + ".", :margin => 0)
          p.separator ""

          if helptext
            p.separator blockquote(" " + helptext)
            p.separator ""
          end

          if self.respond_to? :parser_options
            p.separator "Options:"
            p.separator ""
            parser_options(p)
          end
        end
      end


      def usagebanner
        usage = "Usage: melon #{self.class.command_name}"
        usage << " [options]" if self.respond_to?(:parser_options)
        usage << ' ' << usageargs if usageargs
        usage
      end

      def usageargs; end
      def helptext; end

      def run; raise; end

      def self.description
        raise
      end


      def parse_options!
        begin
          parser.parse!(args)
        rescue OptionParser::ParseError => e
          error "#{self.class.command_name}: #{e}"
        end

        # verify remaining args are files - overrideable
        verify_args
      end

      def verify_args
        args.each do |arg|
          error "no such file: #{arg}" unless File.exists?(arg)
        end
      end
    end
  end
end
