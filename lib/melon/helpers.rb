module Melon
  module Helpers
    def format_command(name, desc, margin = 4, width = 22, wrapdesc = 80)
      pad = "\n" + ' ' * width
      desc = self.wrap_text(desc, wrapdesc - width).split("\n").join(pad)

      ' ' * margin + "#{name.ljust(width-margin)}#{desc}"
    end

    def wrap_text(txt, col = 80)
      txt.gsub(/(.{1,#{col}})( +|$\n?)|(.{1,#{col}})/,
               "\\1\\3\n") 
    end
    
    def error(error_obj_or_str, code = 1)
      if error_obj_or_str.respond_to?('to_s')
        error_str = error_obj_or_str.to_s
      else
        error_str = error_obj_or_str.inspect
      end

      $stderr.puts "melon: #{error_str}"
      exit code
    end
  end
end
