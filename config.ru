# frozen_string_literal: true
$LOAD_PATH << File.expand_path('./lib', __dir__)

require 'bundler/setup'
require 'rack'
require 'rack/auth/basic'
require 'bro'

# Eager-load the Bro codebase
Bro.eager_load!

# Load all bot commands
Dir[Bro.root.join('bot', 'commands', '*.rb')].each do |command|
  require command
end

# Authenticate using HTTP Basic Auth
use Rack::Auth::Basic do |username, password|
  username == Bro::USERNAME && password == Bro::PASSWORD
end

# Respond to commands sent by Basecamp
run Bro::Bot
