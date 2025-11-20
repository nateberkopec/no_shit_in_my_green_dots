# frozen_string_literal: true

require "bundler/gem_helper"
Bundler::GemHelper.install_tasks name: "no_shit_in_my_green_dots"
require "rake/testtask"

desc "Run standardrb (lint)"
task :standard do
  sh "bundle exec standardrb"
end

Rake::TestTask.new(:test) do |t|
  t.libs << "test"
  t.pattern = "test/**/*_test.rb"
end

task default: %i[standard test]
