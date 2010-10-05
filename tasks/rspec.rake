begin
  require 'spec'
rescue LoadError
  require 'rubygems' unless ENV['NO_RUBYGEMS']
  require 'spec'
end
begin
  require 'spec/rake/spectask'
rescue LoadError
  puts <<-EOS
To use rspec for testing you must install rspec gem:
    gem install rspec
EOS
  exit(0)
end

namespace :spec do

  desc "Run all specs"
  Spec::Rake::SpecTask.new(:all) do |t|
    t.spec_opts = ['--options', "spec/spec.opts"]
    t.spec_files = FileList['spec/**/*_spec.rb']
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
