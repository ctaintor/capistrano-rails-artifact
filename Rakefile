require "bundler/gem_tasks"
require 'rake/testtask'
require 'klarna_gem_tagger/tasks'

Rake::TestTask.new do |t|
  t.pattern = "test/**/*_test.rb"
end

task :default => :test
