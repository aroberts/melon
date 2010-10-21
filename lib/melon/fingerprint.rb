require 'rubygems'
require 'active_record'

module Melon
  class Fingerprint < ActiveRecord::Base
    validates_presence_of :file
    validates_presence_of :digest

    validate :file_must_exist

    before_save :make_file_absolute
    before_validation :store_digest

    # protected

    def file_must_exist
      errors.add(:file, "doesn't exist.") unless File.exist?(file)
    end

    def make_file_absolute
      self.file = File.expand_path(file)
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

    def store_digest
      self.digest = calculate_digest if changed.include?("file")
    end
  end
end
