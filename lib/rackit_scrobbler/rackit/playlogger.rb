require 'faye/websocket'
require 'eventmachine'
require "json"

module RackitScrobbler
  module Rackit
    class PlayLogger
      attr_accessor :subscribed_users, :websocket, :listener

      def initialize(listener: nil, usernames: [])
        @listener = listener
        @subscribed_users = usernames
      end

      def start_playlogger
        EM.run do
          listen_to_socket
          check_for_users
        end
      end

      def listen_to_socket
        @websocket = Faye::WebSocket::Client.new(config.playlogger_socket)

        @websocket.onopen = lambda do |event|
          subscribe_users
          puts "Started listening"
        end

        @websocket.onmessage = lambda do |event|
          data = JSON.parse(event.data)
          played_track = RackitScrobbler::Track.try_parse(data)
          return unless played_track
          handle_track(played_track)
        end
      end

      def handle_track(played_track)
        puts "played #{played_track}"
        EM.next_tick do
          if played_track && listener && listener.respond_to?(:playing)
            listener.playing(played_track)
          end
        end
      end

      def check_for_users
        EM.add_periodic_timer(10) do
          add_users(listener.listening_users) if listener.respond_to?(:listening_users)
        end
      end

      def add_users(users)
        EM.next_tick do
          new_users = users - @subscribed_users
          new_users.each {|name| @websocket.send(subscribe_data(name)) }
          @subscribed_users += new_users
          puts "subscribed #{new_users}" if new_users.any?
        end
      end

      def subscribe_users
        subscribed_users.each {|name| @websocket.send(subscribe_data(name)) }
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
