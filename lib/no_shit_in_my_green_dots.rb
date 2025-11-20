# frozen_string_literal: true

require_relative "no_shit_in_my_green_dots/version"

module NoShitInMyGreenDots
  class Error < StandardError; end

  class << self
    def enable!(framework = nil)
      @enabled ||= {}

      frameworks = framework ? [framework] : [:rspec, :minitest]
      frameworks.each { |fw| install_framework(fw) }
    end

    def enabled?(framework = nil)
      return false unless defined?(@enabled)
      return @enabled.values.any? if framework.nil?

      !!@enabled[framework]
    end

    def leak_message(output)
      return "Test wrote to STDOUT (no content captured)." if output.nil? || output.empty?

      trimmed = output.dup
      trimmed = trimmed[0, 720] + "...(truncated)" if trimmed.length > 720
      <<~MSG
        Test wrote to STDOUT:
        ---
        #{trimmed}
        ---
      MSG
    end

    private

    def install_framework(framework)
      return if @enabled[framework]

      case framework
      when :rspec
        require "rspec/core"
        require_relative "no_shit_in_my_green_dots/rspec"
        Integrations::RSpec.install!
      when :minitest
        require "minitest"
        require_relative "no_shit_in_my_green_dots/minitest"
        Integrations::Minitest.install!
      else
        raise Error, "Unknown framework #{framework.inspect}"
      end

      @enabled[framework] = true
    rescue LoadError
      # Framework not available; skip install
    end

    def auto_enable!
      enable!
    end
  end
end

NoShitInMyGreenDots.send(:auto_enable!)
