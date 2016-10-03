# frozen_string_literal: true
#
# Rackup file for the bot.

require_relative './config/bot'
require 'rack'
require 'rack/auth/basic'

# Eager-load the Bro codebase
Bro.eager_load!

# Authenticate using HTTP Basic Auth
use Rack::Auth::Basic do |username, password|
  username == Bro::USERNAME && password == Bro::PASSWORD
end

# Respond to commands sent by Basecamp
run Bro::Bot
