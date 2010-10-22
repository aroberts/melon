begin
  require 'rspec'
rescue LoadError
  require 'rubygems' unless ENV['NO_RUBYGEMS']
  gem 'rspec'
  require 'rspec'
end

$:.unshift(File.dirname(__FILE__) + '/../lib')
require 'melon'
include Melon


def nonexistant_database_file
  'tmp/' + (0..8).map{ ('a'..'z').to_a[rand(26)] }.join + '.db'
end

def non_database_file
  name = nonexistant_database_file
  File.open(name, 'w') {|f| f.write("bad") }
  name
end

def small_media_file
  name = nonexistant_database_file
  File.open(name, 'w') do |f|
    f.write(<<EOS
<p>
It is included in the Ruby standard library.
</p>
<h2>Description</h2>
<p>
ftools adds several (class, not instance) methods to the <a
href="File.html">File</a> class, for copying, moving, deleting, installing,
and comparing files, as well as creating a directory <a
href="File.html#M002554">path</a>. See the <a href="File.html">File</a>
class for details.
</p>
<p>
<a href="FileUtils.html">FileUtils</a> contains all or nearly all the same
functionality and more, and is a recommended option over ftools
</p>
<p>
When you
</p>
<pre>
  require 'ftools'
</pre>
<p>
then the <a href="File.html">File</a> class aquires some utility methods
for copying, moving, and deleting files, and more.
</p>
<p>
See the method descriptions below, and consider using <a
href="FileUtils.html">FileUtils</a> as it is more comprehensive.
</p>
EOS
           )
  end
  name
end
