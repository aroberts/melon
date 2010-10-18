require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')
require 'melon/database'

############ DEPRECATED ###############

describe Melon::Database, "when passing a file that doesn't exist" do
  before do
    @database = Melon::Database.new(nonexistant_database_file)
  end

  after do
    FileUtils.rm_rf(@database.path)
  end
  
  it "should be created" do
    File.exist?(@database.path).should be_true
  end
  
end

describe Melon::Database, "when passing a file that is not a database" do
  before do
    @database = Melon::Database.new(non_database_file)
  end

  after do
    FileUtils.rm_rf(@database.path)
  end

  it "should not be ready" do
    @database.should_not be_ready
  end
end
