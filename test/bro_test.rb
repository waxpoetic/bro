# frozen_string_literal: true
require 'test_helper'

class BroTest < Bro::Test
  test 'defines global logger' do
    assert_kind_of Logger, Bro.logger
  end

  test 'defines root pathname' do
    assert_kind_of Pathname, Bro.root
  end
end
