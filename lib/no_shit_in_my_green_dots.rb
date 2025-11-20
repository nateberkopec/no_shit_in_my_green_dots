# frozen_string_literal: true

require_relative "no_shit_in_my_green_dots/version"

module NoShitInMyGreenDots
  class Error < StandardError; end

  class << self
    def enable!(framework = nil)
      @enabled ||= {}
      framework ||= detect_framework
      raise Error, "Could not detect test framework (minitest or rspec). Call enable!(:minitest) or enable!(:rspec)." unless framework
      return if @enabled[framework]

      case framework
      when :minitest
        require_relative "no_shit_in_my_green_dots/minitest"
        Integrations::Minitest.install!
      when :rspec
        require_relative "no_shit_in_my_green_dots/rspec"
        Integrations::RSpec.install!
      else
        raise Error, "Unknown framework #{framework.inspect}"
      end

      @enabled[framework] = true
    end

    def capture_stdout
      raise Error, "No block given" unless block_given?

      reader, writer = IO.pipe
      original_stdout = $stdout.dup
      original_sync = $stdout.sync
      captured_output = +""
      raised_error = nil

      begin
        $stdout.reopen(writer)
        $stdout.sync = true
        yield
      rescue => e
        raised_error = e
      ensure
        writer.close unless writer.closed?
        $stdout.reopen(original_stdout)
        $stdout.sync = original_sync
        captured_output << reader.read.to_s
        reader.close
        original_stdout.close
      end

      raise raised_error if raised_error
      captured_output
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

    def detect_framework
      return :rspec if defined?(::RSpec)
      :minitest if defined?(::Minitest)
    end

    def auto_enable!
      framework = detect_framework || try_require_and_detect
      enable!(framework) if framework
    end

    def try_require_and_detect
      require "rspec/core"
      detect_framework
    rescue LoadError
      begin
        require "minitest"
        detect_framework
      rescue LoadError
        nil
      end
    end
  end
end

NoShitInMyGreenDots.send(:auto_enable!)
