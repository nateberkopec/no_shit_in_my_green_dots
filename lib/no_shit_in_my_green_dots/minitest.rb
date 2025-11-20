# frozen_string_literal: true

require "minitest"

module NoShitInMyGreenDots
  module Integrations
    module Minitest
      class StdoutLeak < ::Minitest::Assertion
        RESULT_LABEL = "STDOUT"

        def initialize(output)
          super(NoShitInMyGreenDots.leak_message(output))
          set_backtrace(caller)
        end

        def result_label
          RESULT_LABEL
        end
      end

      module TestExtension
        def run
          result = nil
          stdout, = capture_io { result = super }

          unless stdout.nil? || stdout.empty?
            result.failures << StdoutLeak.new(stdout)
          end

          result
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
