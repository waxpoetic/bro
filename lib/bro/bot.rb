# frozen_string_literal: true

module Bro
  # Web application that forms the Bot's basic interface to Basecamp.
  # Messages are sent to the bot via +POST /commands+ and the response
  # is sent back to the Campfire room for the given Basecamp. Browsing
  # the app at its root path will show a listing of all commands.
  class Bot < Sinatra::Base
    set :views, Bro.root.join('lib', 'templates').to_s

    before do
      Bro.logger.info "#{@env['REQUEST_METHOD']} #{@env['PATH_INFO']}"
      Bro.logger.info "Parameters: #{json_params}" if json_params.any?
    end

    after do
      Bro.logger.info "Completed response with status #{response.status}"
    end

    helpers do
      def json_params
        return {} if raw_params.blank?
        @json_params ||= JSON.parse(raw_params).with_indifferent_access
      rescue JSON::ParserError => exception
        Bro.logger.error "Error parsing JSON Parameters: #{exception.message}"
        {}
      end

      private

      def raw_params
        @raw_params ||= request.body.read
      end
    end

    get '/' do
      @commands = Command.all
      erb :index
    end

    post '/commands' do
      @command = Command.find json_params[:command]
      status 200

      if @command.present?
        Bro.logger.info "Responding with command :#{@command.name}..."
        body @command.to_html
      else
        body "Command '#{json_params[:command]}' was not understood."
      end
    end

    post '/messages' do
      @message = Message.create content: request.body.read
      status 200
    end
  end
end
