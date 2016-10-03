# frozen_string_literal: true
require_relative './config/bot'
require 'rake/testtask'
require 'rubocop/rake_task'
require 'bro/command/generator'

Rake::TestTask.new :test do |t|
  t.libs << 'test'
  t.libs << 'lib'
  t.test_files = FileList['test/**/*_test.rb']
end

desc 'Run lint checks'
RuboCop::RakeTask.new :lint

desc 'Generate command with NAME="name_of_file"'
task :command do
  name = ENV['NAME'] || raise('Must define name of command')
  Bro::Command::Generator.create name
  puts "Generated command '#{name}'"
end

task default: :test
