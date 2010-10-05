begin
  require 'cucumber'
rescue LoadError
  require 'rubygems' unless ENV['NO_RUBYGEMS']
  require 'cucumber'
end

begin
  require 'cucumber/rake/task'
rescue LoadError
  puts <<-EOS
To use rspec for testing you must install rspec gem:
    gem install rspec
EOS
  exit(0)
end

namespace :features do
  Cucumber::Rake::Task.new(:all) do |t|
    t.fork = true
    t.cucumber_opts = ['--format', (ENV['CUCUMBER_FORMAT'] || 'progress')]
  end
  # Cucumber::Rake::Task.new(:rcov) do |t|
  #   t.fork = true
  #   t.rcov = true
  #   t.rcov_opts = []
  end
end
