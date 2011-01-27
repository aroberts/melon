require 'rubygems'
require 'digestif/hasher'

module Melon
  class Hasher
    # TODO: scale seek size up with file size
    def self.digest(filename)
      hasher = Digestif::Hasher.new(filename)
      hasher.options.read_size = 40000
      hasher.options.seek_size = 80000000
      hasher.digest
    end
  end
end
