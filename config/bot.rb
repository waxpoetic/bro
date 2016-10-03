$LOAD_PATH << File.expand_path('../lib', __dir__)

require 'bundler/setup'
require 'bro'

# Load all bot commands
Dir[Bro.root.join('bot', 'commands', '*.rb')].each do |command|
  require command
end
