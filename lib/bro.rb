# frozen_string_literal: true
require 'active_support/all'
require 'active_model'
require 'sinatra/base'
require 'logger'
require 'bro/version'

# brother.ly's basecamp chatbot.
module Bro
  extend ActiveSupport::Autoload

  autoload :Bot
  autoload :Message
  autoload :Command

  autoload_under 'command' do
    autoload :Generator
  end

  USERNAME = ENV.fetch('BRO_USERNAME') { 'bro' }
  PASSWORD = ENV.fetch('BRO_PASSWORD') { 'test' }

  ROOT_PATH = File.expand_path('../', __dir__)

  # Global logger object for the entire bot runtime.
  #
  # @return [Logger]
  def self.logger
    @logger ||= Logger.new STDOUT
  end

  # Root path of the Bro codebase.
  #
  # @return [Pathname]
  def self.root
    @root ||= Pathname.new ROOT_PATH
  end
end
