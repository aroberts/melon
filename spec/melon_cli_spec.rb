require File.expand_path(File.dirname(__FILE__) + '/spec_helper')
require 'melon/cli'

describe Melon::CLI, "execute" do
  before(:each) do
    @stdout_io = StringIO.new
    Melon::CLI.execute(@stdout_io, [])
    @stdout_io.rewind
    @stdout = @stdout_io.read
  end
  
  it "should do nothing" do
    @stdout.should =~ //
  end
end
