require 'faye/websocket'
require 'eventmachine'
require "em-synchrony"
require "json"

module RackitScrobbler
  class Rackit
    attr_accessor :player

    def initialize(current_player)
      @player = current_player
    end

    def start_rackmate
      EM.run do
        ws = Faye::WebSocket::Client.new(config.rackmate_socket)

        # TODO: initialize the track on onopen

        ws.onmessage = lambda do |event|
          message = JSON.parse(event.data)
          EM.next_tick do
            if message["track"]
              track = RackitScrobbler::Track.new(message["track"])
              player.current_track = track
            end
            case message["event"]
            when "playbackResumed"
              player.resume
            when "playbackPaused"
              player.pause
            when "trackStarted"
              player.start
            when "ping"
              player.ping(message["fraction"])
            end
          end
        end

      end

    end

    def config
      raise "set rackmate socket" unless RackitScrobbler.config.rackit.rackmate_socket
      RackitScrobbler.config.rackit
    end
  end
end
