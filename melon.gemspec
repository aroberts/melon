lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)
require 'melon/version'

Gem::Specification.new do |s|
    s.name        = %q{melon}
    s.version     = Melon.version
    s.summary     = %q{A media catalog}
    s.description = %q{TODO}

    s.files        = Dir['[A-Z]*', 'lib/**/*.rb', 'features/**/*', 'bin/**/*']
    s.require_path = 'lib'
    s.test_files   = Dir['features/**/*']

    s.default_executable = 'melon'
    s.executables        = ['melon']

    s.has_rdoc = false

    s.authors = ["Andrew Roberts"]
    s.email   = %q{adroberts@gmail.com}
    s.homepage = "http://github.com/aroberts/melon"

    s.add_development_dependency('cucumber')
    s.add_development_dependency('aruba')


    s.platform = Gem::Platform::RUBY
    s.rubygems_version = %q{1.2.0}
end

