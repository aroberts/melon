module Melon
  module Helpers
    def format_command(name, desc, options = {})
      options = {
        :margin => 4,
        :width => 22,
        :wrap => 80
      }.update(options)
      
      pad = "\n" + ' ' * options[:width]
      desc = self.wrap_text(desc, options[:wrap] - options[:width])
      desc = desc.split("\n").join(pad)

      ' ' * options[:margin] +
        "#{name.ljust(options[:width] - options[:margin])}#{desc}"
    end

    def wrap_text(txt, col = 80)
      txt.gsub(/(.{1,#{col}})( +|$\n?)|(.{1,#{col}})/,
               "\\1\\3\n") 
    end

    def blockquote(string, options = {})
      options = {
        :margin => 4,
        :wrap => 70
      }.update(options)
      options[:width] = options.delete(:margin)
      format_command('', string.gsub(/\s+/,' ').gsub('\. ', '.  '), options)
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
