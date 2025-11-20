# frozen_string_literal: true

require "bundler/gem_tasks"
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
