# frozen_string_literal: true
require 'test_helper'

module Bro
  class MessageTest < Test
    def setup
      @params = {
        'command' => 'hello world',
        'creator' => {
          'id' => 12_345
        },
        'callback_url' => 'http://example.com'
      }
      @message = Message.new(@params.to_json)
    end

    test 'parses json params' do
      refute @message.params.empty?
      assert_equal @params, @message.params
    end

    test 'parses command out of json' do
      assert_equal @params['command'], @message.command
    end
  end
end
