# frozen_string_literal: true
$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

# Fake credentials
ENV['BRO_LOG_PATH'] = '/dev/null'
ENV['BASECAMP_CHAT_LINE'] = 'https://3.basecamp.com/X/integrations/X/buckets/X/chats/X/lines'
# ENV['EVENTBRITE_ACCESS_TOKEN'] = 'XXXXXXXXXXXXXXXXXXXX'

require 'bro'

require 'minitest/autorun'
require 'minitest/pride'
require 'codeclimate-test-reporter'
require 'vcr'

CodeClimate::TestReporter.start

class HelloWorld < Bro::Command
  matches %r{hello world}
end

VCR.configure do |c|
  c.cassette_library_dir = 'test/cassettes'
  c.hook_into :webmock
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
