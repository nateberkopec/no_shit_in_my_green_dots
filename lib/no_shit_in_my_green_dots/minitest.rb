# frozen_string_literal: true

require "minitest"

module NoShitInMyGreenDots
  module Integrations
    module Minitest
      module TestExtension
        def run
          result = nil
          stdout, = capture_subprocess_io { result = super }

          unless stdout.nil? || stdout.empty?
            result.failures << stdout_failure(result, stdout)
          end

          result
        end

        private

        def stdout_failure(result, stdout)
          # Use base Assertion so minitest's reporter counts it as a failure.
          failure = ::Minitest::Assertion.new(NoShitInMyGreenDots.leak_message(stdout))
          failure.define_singleton_method(:result_label) { "STDOUT" }
          failure.define_singleton_method(:result_code) { "F" }
          failure.set_backtrace(backtrace_from(result))
          failure
        end

        def backtrace_from(result)
          return caller unless result.respond_to?(:source_location)

          file, line = result.source_location
          return ["#{file}:#{line}"] if file && line && file != "unknown" && line != -1

          caller
        end
      end

      def self.install!
        return if @installed

        require "minitest/test"
        ::Minitest::Test.prepend(TestExtension)
        @installed = true
      end
    end
  end
end
