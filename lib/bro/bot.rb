# frozen_string_literal: true
module Bro
  # Rack application for the bot's webhook interface.
  class Bot
    CONTENT_TYPE = 'text/html'

    attr_reader :input

    # @param env [Rack::Environment]
    def initialize(env)
      @env = env
      @input = env['rack.input'].read
    end

    # Rack app interface.
    #
    # @param env [Rack::Environment]
    # @return [Rack::Response]
    def self.call(env)
      new(env).response.finish
    rescue StandardError => exception
      log_error exception
      error! exception.message
    end

    # Response data for the Rack HTTP server.
    #
    # @return [Array] Rack response.
    def response
      Rack::Response.new [body], status, headers
    end

    # HTTP status code of the request
    #
    # @return [Integer] 200 when command found, 404 when not found
    def status
      command.present? ? 200 : 404
    end

    # Response headers to send back on each request.
    #
    # @return [Hash] HTTP response headers.
    def headers
      {
        'Content-Type' => CONTENT_TYPE
      }
    end

    # The HTML response body of the command.
    #
    # @return [String] HTML response of the command or a blank
    #                  string if command can't be found.
    def body
      Bro.logger.debug "loading command #{command}"
      command&.to_html || ''
    end

    # Command object for this bot.
    #
    # @return [Bro::Command]
    def command
      @command ||= Command.find message.command
    end

    # Input message.
    #
    # @return [Bro::Message]
    def message
      @message ||= Message.new @input
    end

    private

    def error!(message)
      Rack::Response.new [message], 500, headers
    end

    def log_error(exception)
      Bro.logger.error exception.message
      exception.backtrace.each do |line|
        Bro.logger.error line
      end
    end
  end
end
