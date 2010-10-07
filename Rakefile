require 'rubygems'
require 'fileutils'


task :spec => "spec:all"
task :features => "features:all"

desc 'Default: run the cucumber features.'
task :default => :features

Dir['tasks/**/*.rake'].each { |t| load t }
