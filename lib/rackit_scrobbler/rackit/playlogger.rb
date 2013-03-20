require 'faye/websocket'
require 'eventmachine'
require "json"

module RackitScrobbler
  module Rackit
    class PlayLogger
      attr_accessor :usernames, :websocket, :listener

      def initialize(listener: nil, usernames: [])
        @listener = listener
        @usernames = usernames
      end

      def start_playlogger
        EM.run do
          @websocket = Faye::WebSocket::Client.new(config.playlogger_socket)

          @websocket.onopen = lambda do |event|
            subscribe_users
          end

          @websocket.onmessage = lambda do |event|
            data = JSON.parse(event.data)
            played_track = RackitScrobbler::Track.try_parse(data)
            return unless played_track
            handle_track(played_track)
          end
        end

      end

      def handle_track(played_track)
        puts "playing #{played_track}"
        EM.next_tick do
          if played_track && listener && listener.respond_to?(:playing)
            listener.playing(played_track)
          end
        end
      end

      def subscribe_users
        EM.next_tick do
          usernames.each { |name| websocket.send(subscribe_data(name)) }
        end
      end

      def unsubscribe_users
        usernames.each do |name|
          websocket.send(unsubscribe_data(name))
        end
      end

      def add_users(new_names)
        new_names = new_names.is_a?(String) ? [new_names] : new_names
        usernames += new_names
        usernames.uniq!
        subscribe_users
      end

      def subscribe_data(username)
        {route: "/play/#{username}", method: "subscribe"}.to_json
      end

      def unsubscribe_data(username)
        {route: "/play/#{username}", method: "unsubscribe"}.to_json
      end

      def config
        raise "set playlogger socket" unless RackitScrobbler::Rackit.config.playlogger_socket
        RackitScrobbler::Rackit.config
      end


    end
  end
end
