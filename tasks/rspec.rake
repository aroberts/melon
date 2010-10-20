begin
  require 'rspec'
rescue LoadError
  require 'rubygems' unless ENV['NO_RUBYGEMS']
  require 'rspec'
end
begin
  require 'rspec/core/rake_task'
rescue LoadError
  puts <<-EOS
To use rspec for testing you must install rspec gem:
    gem install rspec
EOS
  exit(0)
end

namespace :spec do

  desc "Run all specs"
  RSpec::Core::RakeTask.new(:all) do |t|
    t.rspec_opts = ["-c", "-f progress", "-r ./spec/spec_helper.rb"]
    t.pattern = 'spec/**/*_spec.rb'
  end

  # Spec::Rake::SpecTask.new(:rcov) do |t|
  #   t.spec_opts = ['--options', "\"#{RAILS_ROOT}/spec/spec.opts\""]
  #   t.spec_files = FileList['spec/**/*_spec.rb']
  #   t.rcov = true
  #   t.rcov_opts = lambda do
  #     IO.readlines("#{RAILS_ROOT}/spec/rcov.opts").map {|l| l.chomp.split " "}.flatten
  #   end
  # end
end
