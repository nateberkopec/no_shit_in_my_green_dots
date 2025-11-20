# frozen_string_literal: true

require "test_helper"

class CaptureStdoutTest < Minitest::Test
  def test_captures_output_and_restores_stdout
    original = $stdout

    output = NoShitInMyGreenDots.capture_stdout do
      puts "noisy"
      $stdout.write("still noisy")
    end

    assert_equal original, $stdout
    assert_includes output, "noisy"
    assert_includes output, "still noisy"
  end

  def test_restores_even_when_exception_raised
    original = $stdout

    assert_raises RuntimeError do
      NoShitInMyGreenDots.capture_stdout { raise "boom" }
    end

    assert_equal original, $stdout
  end
end
