require_relative "spec_helper"

include GivenFilesystemSpecHelpers

describe CliController do
  use_given_filesystem

  subject { CliController.new(given_file("simple.pixels")) }

  describe "#work" do
    it "loads specified worker" do
      expect {
        Module.const_get("Nop")
      }.to raise_error(NameError)

      subject.work("nop")

      expect {
        Module.const_get("Nop")
      }.to_not raise_error

      expect(Nop).to be < Worker
    end
  end

  describe "#filename_to_classname" do
    it "one word" do
      expect(subject.filename_to_classname("walk")).to eq("Walk")
    end
    
    it "two words" do
      expect(subject.filename_to_classname("my_worker")).to eq("MyWorker")
    end
  end
end
