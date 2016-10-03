# frozen_string_literal: true
require 'test_helper'
require 'rack/test'

module Bro
  class BotTest < Test
    include Rack::Test::Methods

    def app
      Bro::Bot
    end

    test 'shows command listing on get' do
      get '/'
      assert last_response.ok?, last_response.body
      assert_match 'Hello world', last_response.body
    end

    test 'responds with command on post' do
      post '/commands', { command: 'what time is it' }.to_json
      assert last_response.ok?, last_response.body
      assert_match 'The current time on the server is', last_response.body
    end

    test 'sends message to campfire room' do
      VCR.use_cassette :deliver_message do
        post '/messages', '<p>Test from Bro::Bot</p>'
        assert last_response.ok?
      end
    end
  end
end
