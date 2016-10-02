# frozen_string_literal: true
$LOAD_PATH << File.expand_path('./lib', __dir__)

require 'bundler/setup'
require 'rack'
require 'rack/auth/basic'
require 'bro'

# Eager-load the Bro codebase
Bro.eager_load!

# Authenticate using HTTP Basic Auth
use Rack::Auth::Basic.new do |username, password|
  username == Bro::USERNAME && password == Bro::PASSWORD
end

# Respond to commands sent by Basecamp
run Bro::Bot
