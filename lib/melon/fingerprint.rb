require 'rubygems'
require 'active_record'

module Melon
  class Fingerprint < ActiveRecord::Base
    validates_presence_of :path
    validates_presence_of :hash
    

  end
end
