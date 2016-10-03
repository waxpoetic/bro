# frozen_string_literal: true
require 'test_helper'

module Bro
  class CommandTest < Test
    def setup
      @input = 'hello world'
      @command = HelloWorld.new input: @input
    end

    test 'finds name of command' do
      assert_equal 'hello_world', @command.name
    end

    test 'finds command by input' do
      assert_equal 'hello_world', Command.find(@input).name
      assert_equal @input, Command.find(@input).instance_variable_get('@input')
      assert_nil Command.find('not a command')
    end

    test 'describes command' do
      Command.desc 'description'
      assert_equal 'description', Command.description
    end

    test 'sets matcher regex' do
      Command.matches %r{test}
      assert_equal %r{test}, Command.matcher
    end

    test 'registers command upon being inherited' do
      assert Command.all.include?(HelloWorld), Command.all
    end

    test 'responds with html' do
      assert_match(
        'bot/templates/hello_world.erb',
        @command.send(:template_path).to_s
      )
      html = "<p>hello world</p>\n"
      assert_equal html, @command.send(:template)
      assert_equal html, @command.to_html
    end
  end
end
