require 'rubygems'
require 'digestif/hasher'

module Melon
  class Hasher
    # TODO: scale seek size up with file size
    # 100M        => 0
    # 1000M       => 
    # 2000M       =>
    #
    # Data points for 3s:
    # 4194996638  => 40000000
    # 6372304495  => 80000000
    # 2346880790  => 29000000
    # 11730897879 => 190000000
    # 5451346280  => 76000000
    # 7007074117  => 95000000
    def self.digest(filename)
      hasher = Digestif::Hasher.new(filename)
      hasher.options.read_size = 40000
      hasher.options.seek_size = self.seek_size(filename)
      # hasher.options.seek_size = 80000000
      hasher.digest
    end

    def self.seek_size(filename)
      # get the file size in megs
      file_size = File.size(filename) / 1024 ** 2
      case file_size
      when 0...150 then 0
      when 150...2000 then 15000000
      else file_size * 18629 - 24863642
      end
    end
  end
end
