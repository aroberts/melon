require 'melon/fingerprint'
require 'melon/database' # may need to reverse the order of these

describe Melon::Fingerprint, "when creating with just a file" do
  before do
    File.stub!(:exist?) { true }

    @database = Melon::Database.new(nonexistant_database_file)
    @fingerprint = Melon::Fingerprint.new(:file => small_media_file)
    @fingerprint.save!
  end

  after do
    FileUtils.rm_rf(@database.path)
  end
  
  it "should resolve the path" do
    @fingerprint.file.should match(/^\//)
  end

  it "should be valid" do
    @fingerprint.should be_valid
  end

  it "should set the digest field" do
    @fingerprint.digest.should_not be_nil
  end
  
end
