# frozen_string_literal: true

require "rspec/core"

module NoShitInMyGreenDots
  module Integrations
    module RSpec
      class StdoutLeak < StandardError
        def initialize(output)
          super(NoShitInMyGreenDots.leak_message(output))
        end
      end

      def self.install!
        return if @installed

        ::RSpec.configure do |config|
          config.around do |example|
            matcher = ::RSpec::Matchers::BuiltIn::Output.new(nil).to_stdout_from_any_process
            matcher.matches?(-> { example.run })
            captured_output = matcher.instance_variable_get(:@actual).to_s

            next if captured_output.nil? || captured_output.empty?
            next if example.exception

            raise StdoutLeak.new(captured_output)
          end
        end

        @installed = true
      end
    end
  end
end
