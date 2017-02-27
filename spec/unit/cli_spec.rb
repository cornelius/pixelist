require_relative "spec_helper"

require "cli_tester"

include CliTester
include GivenFilesystemSpecHelpers

describe "CLI" do
  use_given_filesystem

  before do
    @pixels_file = Pathname(given_directory) + "beautiful.pixels"
  end

  describe "help" do
    it "shows help" do
      expect(run_command(args: ["help"])).to exit_with_success(/SYNOPSIS/)
    end
  end

  describe "init" do
    it "creates pixel matrix file with default size of 4x4" do
      expect(run_command(args: ["--pixels", @pixels_file, "init"])).to exit_with_success("Created pixel file at '#{@pixels_file}'\n")
      expect(File.exist?(@pixels_file)).to be(true)
      expect(File.read(@pixels_file)).to eq("0000\n0000\n0000\n0000\n")
    end

    it "creates square pixel file with given size" do
      expect(run_command(args: ["--pixels", @pixels_file, "init", "2"])).to exit_with_success
      expect(File.read(@pixels_file)).to eq("00\n00\n")
    end

    it "creates rectangular pixel file with given dimensions" do
      expect(run_command(args: ["--pixels", @pixels_file, "init", "2", "3"])).to exit_with_success
      expect(File.read(@pixels_file)).to eq("00\n00\n00\n")
    end
  end

  describe "show" do
    it "shows pixels" do
      expected_pixels = "+--+\n|  |\n|  |\n|  |\n+--+\n"
      expect(run_command(args: ["--pixels", @pixels_file, "init", "2", "3"])).to exit_with_success
      expect(run_command(args: ["--pixels", @pixels_file, "show"])).to exit_with_success(expected_pixels)
    end
  end

  describe "set" do
    it "sets pixel" do
      expected_pixels = "00\n01\n00\n"
      expect(run_command(args: ["--pixels", @pixels_file, "init", "2", "3"])).to exit_with_success
      expect(run_command(args: ["--pixels", @pixels_file, "set", "1", "1"])).to exit_with_success
      expect(File.read(@pixels_file)).to eq(expected_pixels)
    end
  end
end
