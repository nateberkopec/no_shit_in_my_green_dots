# frozen_string_literal: true

require_relative "test_helper"

class PluginNoisyTest < Minitest::Test
  def test_noise
    puts "direct write"
    assert_equal 1, 1
  end
end
