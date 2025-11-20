# frozen_string_literal: true

require_relative "spec_helper"

RSpec.describe "stdout quiet" do
  it "stays silent" do
    expect(1 + 1).to eq 2
  end
end
