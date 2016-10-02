# frozen_string_literal: true
module Bro
  # Wraps the JSON message sent from Basecamp.
  class Message
    def initialize(input)
      @input = input
    end

    def command
      params[:command]
    end

    def params
      @params ||= JSON.parse(@input).with_indifferent_access
    rescue JSON::ParserError => exception
      Bro.logger.error exception.message
      {}
    end
  end
end
