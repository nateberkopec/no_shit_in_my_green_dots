# frozen_string_literal: true

require_relative "test_helper"
require "logger"

class NoisyTest < Minitest::Test
  def test_noise
    puts "direct write"
    Logger.new($stdout).info("logger write")
    system("printf child_output")
  end
end
