# frozen_string_literal: true
require 'test_helper'

class TicketSalesTest < Bro::Test
  setup do
    @command = TicketSales.new input: 'how many tickets have we sold'
  end

  test 'computes event ticket classes path' do
    assert_match '/v3/events', @command.send(:event_ticket_classes_path)
    assert_match '/ticket_classes', @command.send(:event_ticket_classes_path)
  end

  test 'instantiates https client' do
    assert_kind_of Net::HTTP, @command.send(:http)
  end

  test 'performs successful get request' do
    VCR.use_cassette :eventbrite_ticket_classes do
      assert_kind_of Net::HTTPSuccess, @command.send(:response)
    end
  end

  test 'shows how many tickets have been sold' do
    VCR.use_cassette :eventbrite_ticket_classes do
      attrs = @command.send(:tiers).first.keys
      assert attrs.include?('quantity_sold'), attrs
      assert_equal 12, @command.tickets
    end
  end

  test 'finds ticket tier data from parsed response' do
    VCR.use_cassette :eventbrite_ticket_classes do
      assert @command.send(:body)['ticket_classes'].many?, @command.send(:body)
      assert @command.send(:tiers).many?, @command.send(:tiers)
    end
  end
end
