# frozen_string_literal: true
require 'test_helper'

module Bro
  class BotTest < Test
    def setup
      @input = Minitest::Mock.new
      json = {
        'command' => 'hello world',
        'creator' => {},
        'callback_url' => ''
      }.to_json
      @input.expect(:read, json)
      @env = { 'rack.input' => @input }
      @bot = Bot.new @env
    end

    test 'responds with html' do
      assert_equal 'text/html', @bot.headers['Content-Type']
    end

    test 'finds proper status' do
      assert_equal 200, @bot.status
    end
  end
end
