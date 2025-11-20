# frozen_string_literal: true

require_relative "spec_helper"

RSpec.describe "stdout noise" do
  it "fails when writing to stdout" do
    puts "spec noise"
  end

  it "fails when child writes to stdout" do
    pid = fork { $stdout.puts "spec_child" }
    Process.wait(pid)
  end
end
