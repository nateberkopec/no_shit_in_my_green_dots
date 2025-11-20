# frozen_string_literal: true

$LOAD_PATH.unshift(File.expand_path("../../../../../lib", __dir__))

require "rspec"
require "no_shit_in_my_green_dots"

NoShitInMyGreenDots.enable!(:rspec)

RSpec.configure do |config|
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
