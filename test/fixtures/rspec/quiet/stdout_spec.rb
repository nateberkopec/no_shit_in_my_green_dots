# frozen_string_literal: true

require_relative "spec_helper"

RSpec.describe "RSpec STDOUT enforcement (quiet)" do
  it "stays quiet" do
    expect(1 + 1).to eq(2)
  end

  it "also stays quiet" do
    expect("a").to start_with("a")
  end
end
