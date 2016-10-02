# frozen_string_literal: true
class ServerTime < Bot::Command
  desc 'Returns the current time on the server'
  matches %r{what time is it}
end
