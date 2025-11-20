# frozen_string_literal: true

require_relative "spec_helper"

RSpec.describe "RSpec STDOUT enforcement (noisy)" do
  it "fails when writing to stdout" do
    puts "spec noise"
    system("printf spec_child")
  end
end
