require 'rubygems'

module Melon
  class Fingerprint

    attr_reader :file, :digest

    def initialize(file)
      # check errors
      @file = File.expand_path(file)
      validate!
      @digest = calculate_digest
    end

    def validate!
      raise "File '#{file}' doesn't exist." unless File.exist?(file)
    end

    def calculate_digest
      # these are all constants for the function.  I pulled them out
      # here for convenience
      small_file_threshold = 1024**2
      sample_count = 256
      sample_size = 512

      file_size = File.size(file)
      
      # < small_file_threshold, hash whole file
      if file_size < small_file_threshold
        Digest::SHA1.hexdigest(File.read(file))
      else
        seek_size = (file_size / sample_count) - sample_size
        hasher = Digest::SHA1.new
        File.open(file, "r") do |f|
          until f.eof
            hasher.update(f.read(sample_size))
            f.seek(seek_size, IO::SEEK_CUR)
          end
        end
        hasher.hexdigest
      end
    end
  end
end
