require 'melon/database'

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
    @file = non_database_file
  end

  after do
    FileUtils.rm_rf(@file)
  end

  it "should throw an exception" do
    lambda {
      @database = Melon::Database.new(non_database_file)
    }.should raise_error(ActiveRecord::StatementInvalid)
  end
end
