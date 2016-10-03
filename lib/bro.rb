# frozen_string_literal: true
require 'active_support/all'
require 'active_model'
require 'sinatra/base'
require 'logger'
require 'bro/version'

# A Basecamp chatbot using the specification in the Basecamp 3 API.
# Accepts messages sent over HTTP POST to a +/commands+ route on the web
# application and processes them as +Bro::Command+ objects. Commands
# come with a conventional +ERB+ template that can be used to customize
# the response sent back to Campfire.
#
# Bro is used by the brother.ly team to help coordinate actions in
# Campfire, as well as providing notifications from our various web
# services.
module Bro
  extend ActiveSupport::Autoload

  autoload :Bot
  autoload :Command

  autoload_under 'command' do
    autoload :Generator
  end

  # @return [String] Configured username for authentication.
  USERNAME = ENV.fetch('BRO_USERNAME') { 'bro' }

  # @return [String] Configured password for authentication.
  PASSWORD = ENV.fetch('BRO_PASSWORD') { 'test' }

  # @return [Boolean] Whether to show debug log messages.
  DEBUG = ENV.fetch('BRO_DEBUG') { false }

  # @return [String] Path to log file or +STDOUT+ by default.
  LOG_PATH = ENV.fetch('BRO_LOG_PATH') { STDOUT }

  # Global logger object for the entire bot runtime.
  #
  # @return [Logger]
  def self.logger
    @logger ||= Logger.new(LOG_PATH).tap do |log|
      log.level = DEBUG ? Logger::DEBUG : Logger::INFO
      log.formatter = proc do |severity, _datetime, progname, message|
        level = severity =~ /info/i ? nil : severity.upcase
        [level, progname, message].compact.join("\s") + "\n"
      end
    end
  end

  # Root path of the Bro codebase.
  #
  # @return [Pathname]
  def self.root
    @root ||= Pathname.new File.expand_path('../', __dir__)
  end

  def self.eager_load!
    logger.info 'Starting chatbot...'
    super
  end
end

Dir[Bro.root.join('bot', 'commands', '*.rb')].each do |command|
  Bro.logger.debug "Loading #{command}"
  require command
end
