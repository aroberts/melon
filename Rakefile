require 'rubygems'
require 'fileutils'

desc 'Default: run the cucumber features.'
task :default => "features:all"
task :spec => "spec:all"

Dir['tasks/**/*.rake'].each { |t| load t }
