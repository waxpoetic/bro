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

  # Global logger object for the entire bot runtime.
  #
  # @return [Logger]
  def self.logger
    @logger ||= Logger.new(STDOUT).tap do |log|
      log.formatter = proc do |severity, datetime, progname, message|
        level = severity =~ /info/i ? nil : "[#{severity.downcase}]"
        [progname, datetime, level, message].compact.join("\s") + "\n"
      end
      log.level = Logger::DEBUG
    end
  end

  # Root path of the Bro codebase.
  #
  # @return [Pathname]
  def self.root
    @root ||= Pathname.new File.expand_path('../', __dir__)
  end
end

Dir[Bro.root.join('bot', 'commands', '*.rb')].each do |command|
  Bro.logger.debug "Loading #{command}"
  require command
end
