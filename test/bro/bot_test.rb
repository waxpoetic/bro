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
      assert_match 'hello world', last_response.body
    end

    test 'responds with command on post' do
      post '/', 'command' => 'hello world'
      assert last_response.ok?
      assert_equal "<p>hello world</p>\n", last_response.body
    end
  end
end
