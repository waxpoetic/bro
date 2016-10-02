# frozen_string_literal: true
module Bro
  # Base class for all commands the bot can understand.
  class Command
    extend ActiveModel::Naming

    class_attribute :matcher, :description

    # @param :input [String] Full input text.
    def initialize(input: '')
      @input = input
    end

    # All commands known to the system.
    #
    # @return [Array<Class>]
    def self.all
      @all ||= []
    end

    # Register command when inherited and loaded.
    #
    # @param command [Class]
    def self.inherited(command)
      all << command
    end

    # Find a command based on whether it matches a given input.
    #
    # @param input [String] Input given in Basecamp
    # @return [Bro::Command] or +nil+
    def self.find(input)
      all.find do |command|
        input =~ command.matcher
      end.new(input: input)
    rescue LoadError, NoMethodError
      Bro.logger.error "Couldn't find command for '#{input}'"
      nil
    end

    # Add matcher for this command.
    #
    # @param regexp [RegExp]
    def self.matches(regexp)
      self.matcher = regexp
    end

    # Add description for this command.
    #
    # @param text [String]
    def self.desc(text)
      self.description = text
    end

    # Name of this command for use in filename paths.
    #
    # @return [String] Parameterized name of the command.
    def name
      model_name.param_key
    end

    # Respond to the request with HTML.
    #
    # @return [String] Result of this command as HTML.
    def to_html
      return '' unless template.present?
      ERB.new(template).result(binding)
    end

    private

    # @private
    # @return [String] Full contents of the ERB template.
    def template
      File.read template_path
    end

    # @private
    # @return [Pathname] File path to the ERB template.
    def template_path
      Bro.root.join('bot', 'templates', "#{name}.erb")
    end
  end
end
