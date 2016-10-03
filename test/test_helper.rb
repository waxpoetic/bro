# frozen_string_literal: true
$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'bro'

require 'minitest/autorun'
require 'minitest/pride'
require 'codeclimate-test-reporter'
CodeClimate::TestReporter.start

class HelloWorld < Bro::Command
  matches %r{hello world}
end

module Bro
  class Test < ActiveSupport::TestCase
    # Small DSL for spec'ing out tests that haven't been implemented
    # yet.
    def self.spec(name)
      test(name) do
        skip 'not implemented yet'
      end
    end
  end
end
