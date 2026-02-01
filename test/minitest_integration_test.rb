# frozen_string_literal: true

require "test_helper"
require "open3"

class MinitestIntegrationTest < Minitest::Test
  def test_suite_fails_when_stdout_is_used
    status, output = run_minitest_suite(fixture: "noisy")

    refute status.success?, "Expected minitest suite to fail when STDOUT is used"
    assert_includes output, "Test wrote to STDOUT"
    assert_includes output, "1 failures"
    assert_includes output, "noisy_suite.rb:7"
    assert_includes output, "direct write"
    assert_includes output, "logger write"
    assert_includes output, "child_output"
  end

  def test_suite_fails_without_explicit_require
    status, output = run_minitest_suite(fixture: "plugin_noisy")

    refute status.success?, "Expected minitest suite to fail without explicit require when STDOUT is used"
    assert_includes output, "Test wrote to STDOUT"
    assert_includes output, "plugin_noisy_suite.rb:6"
    assert_includes output, "direct write"
  end

  def test_suite_passes_when_quiet
    status, output = run_minitest_suite(fixture: "quiet")

    assert status.success?, "Expected quiet minitest suite to pass"
    refute_includes output, "Test wrote to STDOUT"
  end

  private

  def run_minitest_suite(fixture:)
    fixture_path = File.expand_path("fixtures/minitest/#{fixture}", __dir__)
    filename = "#{fixture}_suite.rb"
    stdout, stderr, status = Open3.capture3(
      bundle_env,
      "bundle",
      "exec",
      "ruby",
      filename,
      chdir: fixture_path
    )

    [status, stdout + stderr]
  end

  def bundle_env
    {"BUNDLE_GEMFILE" => File.expand_path("../Gemfile", __dir__)}
  end
end
