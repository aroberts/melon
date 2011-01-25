lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)
require 'melon/version'

Gem::Specification.new do |s|
    s.name        = %q{melon}
    s.version     = Melon.version
    s.summary     = %q{A media catalog}
    s.description = %q{A tool for tracking files based on content, aiming to scale to arbitrarily large files without slowing down}

    s.files         = `git ls-files`.split("\n")
    s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
    s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
    s.default_executable = 'melon'

    s.require_path = 'lib'

    s.has_rdoc = false

    s.authors = ["Andrew Roberts"]
    s.email   = %q{adroberts@gmail.com}
    s.homepage = "http://github.com/aroberts/melon"

    s.add_dependency("digestif", ">=1.0.4")

    s.add_development_dependency('cucumber')
    s.add_development_dependency('aruba')

    s.platform = Gem::Platform::RUBY
    s.rubygems_version = %q{1.2.0}
end

