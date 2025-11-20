# frozen_string_literal: true

require_relative "gemspec_helper"

NoShitInMyGreenDots::GemspecHelper.build(
  name: "no_stuff_in_my_green_dots",
  gemspec_filename: File.basename(__FILE__)
)
