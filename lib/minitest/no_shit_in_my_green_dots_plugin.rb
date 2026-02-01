# frozen_string_literal: true

require "no_shit_in_my_green_dots"

module Minitest
  def self.plugin_no_shit_in_my_green_dots_init(_options)
    NoShitInMyGreenDots.enable!(:minitest)
  end
end
