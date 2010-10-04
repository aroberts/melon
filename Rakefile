require 'rubygems'
require 'fileutils'

require 'cucumber/rake/task'

desc 'Default: run the cucumber features.'
task :default => :cucumber

Cucumber::Rake::Task.new(:cucumber) do |t|
  t.fork = true
  t.cucumber_opts = ['--format', (ENV['CUCUMBER_FORMAT'] || 'progress')]
end

Dir['tasks/**/*.rake'].each { |t| load t }
