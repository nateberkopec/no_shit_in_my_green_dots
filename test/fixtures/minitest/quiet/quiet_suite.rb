# frozen_string_literal: true

require_relative "test_helper"

class QuietTest < Minitest::Test
  def test_math
    assert_equal 2, 1 + 1
  end

  def test_string
    assert_includes %w[a b c], "a"
  end
end
