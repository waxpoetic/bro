module Bro
  # A message sent back to Campfire using the chat line protocol.
  class Message
    # @return [String] Configurable fully-qualified path to chatline.
    BASECAMP_CHAT_LINE = ENV['BASECAMP_CHAT_LINE'] || raise('No chat line found')

    # @return [String] HTML content of the message.
    attr_reader :content

    # @param content [String] HTML to send to Campfire room.
    def initialize(content: '')
      @content = content
    end

    # Immediately deliver a message to the Campfire room.
    #
    # @param content [String] HTML to send to Campfire room.
    def self.create(content: '')
      new(content: content).tap(&:deliver)
    end

    # Send a +POST+ request to the Campfire room with the given message
    # content.
    #
    # @return [Boolean] whether request was successful.
    def deliver
      @delivered = response.is_a? Net::HTTPSuccess
    end

    # Test whether message was delivered.
    #
    # @return [Boolean] whether HTTP request was successful.
    def delivered?
      @delivered
    end

    private

    def request
      @request ||= Net::HTTP::Post.new(chat_line).tap do |req|
        req.set_form_data 'content' => content
      end
    end

    def response
      @res ||= Net::HTTP.start(chat_line.hostname, chat_line.port, use_ssl: true) do |http|
        http.request(request)
      end
    end

    # @private
    # @return [Net::HTTP] HTTP client for Basecamp API requests.
    def http
      @http ||= Net::HTTP.new(chat_line.host, 443).tap do |client|
        client.use_ssl = true
      end
    end

    def params
      URI.encode_www_form 'content' => content
    end

    # @return [URI] URL to the chat line.
    def chat_line
      @chat_line ||= URI.parse BASECAMP_CHAT_LINE
    end
  end
end
