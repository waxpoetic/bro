# frozen_string_literal: true

module Bro
  # Web application that forms the Bot's basic interface to Basecamp.
  # Messages are sent to the bot via +POST /commands+ and the response
  # is sent back to the Campfire room for the given Basecamp. Browsing
  # the app at its root path will show a listing of all commands.
  class Bot < Sinatra::Base
    set :views, Bro.root.join('lib', 'templates').to_s

    get '/' do
      @commands = Command.all
      erb :index
    end

    post '/commands' do
      Bro.logger.info "Basecamp requested command response"
      params = JSON.parse(request.body.read)
      Bro.logger.info "Parameters: #{params}"
      @command = Command.find params['command']
      status 200

      if @command.present?
        Bro.logger.info "Responding with #{@command.name}"
        body @command.to_html
      else
        body "Command '#{params['command']}' was not understood."
      end
    end
  end
end
