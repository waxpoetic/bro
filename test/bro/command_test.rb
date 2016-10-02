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
    end

    test 'responds with html' do
      assert_match(
        'lib/templates/hello_world.erb',
        @command.send(:template_path).to_s
      )
      html = "<p>hello world</p>\n"
      assert_equal html, @command.send(:template)
      assert_equal html, @command.to_html
    end
  end
end
