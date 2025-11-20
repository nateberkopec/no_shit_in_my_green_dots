# frozen_string_literal: true

require_relative "lib/no_shit_in_my_green_dots/version"

Gem::Specification.new do |spec|
  spec.name = "no_shit_in_my_green_dots"
  spec.version = NoShitInMyGreenDots::VERSION
  spec.authors = ["Nate Berkopec"]
  spec.email = ["nate.berkopec@gmail.com"]

  spec.summary = "Fails tests that leak STDOUT into your green dots."
  spec.description = "A small helper you drop into spec_helper.rb or test_helper.rb to fail examples that write to STDOUT."
  spec.homepage = "https://github.com/nateberkopec/no_shit_in_my_green_dots"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.2.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/nateberkopec/no_shit_in_my_green_dots"
  spec.metadata["rubygems_mfa_required"] = "true"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  gemspec = File.basename(__FILE__)
  spec.files = IO.popen(%w[git ls-files -z], chdir: __dir__, err: IO::NULL) do |ls|
    ls.readlines("\x0", chomp: true).reject do |f|
      (f == gemspec) ||
        f.start_with?(*%w[bin/ Gemfile .gitignore])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "minitest", "~> 5.21"
  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "rspec", "~> 3.13"
  spec.add_development_dependency "standard", "~> 1.40"
end
