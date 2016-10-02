# frozen_string_literal: true
module Bro
  # Rack application for the bot's webhook interface.
  class Bot < Sinatra::Application
    set :views, Bro.root.join('bot', 'templates').to_s

    # Bot commands listing
    get '/' do
      @commands = Command.all
      erb :index, views: Bro.root.join('lib', 'templates').to_s
    end

    post '/' do
      @command = Command.find params['command']
      status 200

      if @command.present?
        erb @command.name
      else
        body "Command '#{params['command']}' was not understood."
      end
    end
  end
end
