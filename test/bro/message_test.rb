require 'test_helper'

module Bro
  class MessageTest < Test
    setup do
      @content = "<p>Sent from Bro v#{Bro::VERSION}.</p>"
      @message = Message.new content: @content
    end

    test 'sets up http client' do
      http_client = @message.send :http

      assert_kind_of Net::HTTP, http_client
    end

    test 'parses uri from env' do
      chat_line = @message.send :chat_line

      assert_kind_of URI, chat_line
      assert_equal '3.basecamp.com', chat_line.host
      assert_match 'lines', chat_line.path
    end

    test 'stores html content' do
      assert_equal @content, @message.content
    end

    test 'sends message to campfire room' do
      VCR.use_cassette :deliver_message do
        assert @message.deliver
        assert Message.create(content: 'Another message').delivered?
      end
    end
  end
end
