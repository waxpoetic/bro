# frozen_string_literal: true

module Bro
  # Rack application for the bot's webhook interface.
  class Bot < Sinatra::Base
    set :views, Bro.root.join('lib', 'templates').to_s

    get '/' do
      @commands = Command.all
      erb :index
    end

    post '/' do
      @command = Command.find params['command']
      status 200
      body @command.to_html
    end
  end
end
