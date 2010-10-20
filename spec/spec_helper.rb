begin
  require 'rspec'
rescue LoadError
  require 'rubygems' unless ENV['NO_RUBYGEMS']
  gem 'rspec'
  require 'rspec'
end

$:.unshift(File.dirname(__FILE__) + '/../lib')
require 'melon'


def nonexistant_database_file
  'tmp/' + (0..8).map{ ('a'..'z').to_a[rand(26)] }.join + '.db'
end

def non_database_file
  name = nonexistant_database_file
  File.open(name, 'w') {|f| f.write("bad") }
  name
end
