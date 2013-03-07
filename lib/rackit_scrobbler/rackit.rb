require 'faye/websocket'
require 'eventmachine'
require "json"

module RackitScrobbler
  class Rackit

    def start_paylogger
      EM.run do
        ws = Faye::WebSocket::Client.new("ws://playlogger.rackit.co:9996/rackmate")
        ws.onopen = lambda do |event|
          ws.send(login_data.to_json)
        end

        ws.onmessage = lambda do |event|
          message = JSON.parse(event.data)
          puts "Message: #{message.inspect}"
        end

      end
    end

    def start_local
      EM.run do
        ws = Faye::WebSocket::Client.new("ws://localhost:13581")

        ws.onmessage = lambda do |event|
          message = JSON.parse(event.data)
          puts "Message: #{message.inspect}"
        end

      end

    end

    def config
      raise "missing email" unless RackitScrobbler.config.rackit.email
      raise "missing user id" unless RackitScrobbler.config.rackit.user
      raise "missing pass_key" unless RackitScrobbler.config.rackit.pass_key
      RackitScrobbler.config.rackit
    end

    def login_data
      {userid: config.user,passkey: config.pass_key}
    end

  end
end
