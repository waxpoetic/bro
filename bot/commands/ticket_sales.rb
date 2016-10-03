require 'net/http'

class TicketSales < Bro::Command
  EVENTBRITE_EVENT_ID = ENV['EVENTBRITE_EVENT_ID']
  EVENTBRITE_ACCESS_TOKEN = ENV['EVENTBRITE_ACCESS_TOKEN']
  EVENTBRITE_API_URL = 'www.eventbriteapi.com'

  matches %r{how many tickets have we sold}

  def tickets
    @tickets ||= begin
      Bro.logger.debug "Found #{tiers.count} ticket tiers"
      tiers.sum do |tier|
        tier['quantity_sold']
      end
     end
  end

  private

  def http
    @http ||= Net::HTTP.new(EVENTBRITE_API_URL, 443).tap do |client|
      client.use_ssl = true
    end
  end

  def response
    http.get "/v3/events/#{EVENTBRITE_EVENT_ID}/ticket_classes/", {
      'Authorization' => "Bearer #{EVENTBRITE_ACCESS_TOKEN}"
    }
  end

  def body
    JSON.parse response.body
  rescue JSON::ParserError
    { 'ticket_classes' => [] }
  end

  def tiers
    body['ticket_classes'] || []
  end
end
