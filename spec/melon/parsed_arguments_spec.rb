require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')
require 'melon/parsed_arguments'

describe Melon::ParsedArguments, "when splitting valid arguments" do
  before do
    @args = Melon::ParsedArguments.new(%w(-t -b help plate /path/to/file -t 5))
  end
  
  it "should correctly find the program arguments" do
    @args.program_arguments.should include("-t", "-b")
    @args.program_arguments.length.should == 2
  end

  it "should correctly find the command" do
    @args.command.should == "help"
  end

  it "should correctly find the command arguments" do
    @args.command_arguments.should include("plate", "/path/to/file", "-t", "5")
    @args.command_arguments.length.should == 4
  end
end

describe Melon::ParsedArguments, "when splitting argument-less commands" do
  before do
    @args = Melon::ParsedArguments.new(%w(help))
  end
  
  it "should correctly find the program arguments" do
    @args.program_arguments.should be_empty
  end

  it "should correctly find the command" do
    @args.command.should == "help"
  end

  it "should correctly find the command arguments" do
    @args.command_arguments.should be_empty
  end
end

describe Melon::ParsedArguments, "when splitting command-less arguments" do
  before do
    @args = Melon::ParsedArguments.new(%w(--help))
  end

  it "should set the program arguments" do
    @args.program_arguments.should include("--help")
    @args.program_arguments.length.should == 1
  end

  it "shound not set a command" do
    @args.command.should be_nil
  end
  
  it "should not set any command arguments" do
    @args.command_arguments.should be_nil
  end
end

describe Melon::ParsedArguments, "when splitting invalid commands" do
  before do
    @args = Melon::ParsedArguments.new(%w(fizzle))
  end

  it "should not set a command" do
    @args.command.should be_nil
  end

  it "should treat the invalid command as a program argument" do
    @args.program_arguments.should include("fizzle")
    @args.program_arguments.length.should == 1
  end

  it "should not set command arguments" do
    @args.command_arguments.should be_nil
  end
end
