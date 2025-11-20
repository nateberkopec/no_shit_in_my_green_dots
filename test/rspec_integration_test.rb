# frozen_string_literal: true

require "test_helper"
require "open3"

class RSpecIntegrationTest < Minitest::Test
  def test_suite_fails_when_stdout_is_used
    status, output = run_rspec_suite(fixture: "noisy")

    refute status.success?, "Expected rspec suite to fail when STDOUT is used"
    assert_includes output, "Test wrote to STDOUT"
    assert_includes output, "spec noise"
    assert_includes output, "spec_child"
  end

  def test_suite_passes_when_quiet
    status, output = run_rspec_suite(fixture: "quiet")

    assert status.success?, "Expected quiet rspec suite to pass"
    refute_includes output, "Test wrote to STDOUT"
  end

  private

  def run_rspec_suite(fixture:)
    fixture_path = File.expand_path("fixtures/rspec/#{fixture}", __dir__)

    stdout, stderr, status = Open3.capture3(
      bundle_env,
      "bundle",
      "exec",
      "rspec",
      "--format",
      "progress",
      "stdout_spec.rb",
      chdir: fixture_path
    )

    [status, stdout + stderr]
  end

  def bundle_env
    {"BUNDLE_GEMFILE" => File.expand_path("../Gemfile", __dir__)}
  end
end
