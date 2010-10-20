require 'rubygems'
require 'active_record'

module Melon
  class Fingerprint < ActiveRecord::Base
    validates_presence_of :file
    validates_presence_of :digest

    validate :file_must_exist

    before_save :make_file_absolute

    protected

    def file_must_exist
      errors.add(:file, "doesn't exist.") unless File.exist?(file)
    end

    def make_file_absolute
      self.file = File.expand_path(file)
    end
  end
end
