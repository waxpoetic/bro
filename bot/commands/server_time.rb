# frozen_string_literal: true
class ServerTime < Bro::Command
  desc 'Returns the current time on the server'
  matches %r{what time is it}
end
