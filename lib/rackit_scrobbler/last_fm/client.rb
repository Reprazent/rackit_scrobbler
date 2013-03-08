require "lastfm"

module RackitScrobbler
  module LastFm
    class Client

      attr_accessor :lastfm_instance

      def initialize
        @lastfm_instance = Lastfm.new(LastFm.config.api_key, LastFm.config.api_secret)
      end

      def authenticated?
        lastfm_instance.session
      end

      def authenticate
        lastfm_instance.session = LastFm::Authenticator.new(lastfm_instance).session_key
      end

      def reauthenticate
        lastfm_instance.session = LastFm::Authenticator.new(lastfm_instance).session_key(true)

      end

      def playing(track)
        begin
          lastfm_instance.track.update_now_playing(artist: track.artist, track: track.title)
        rescue Lastfm::ApiError => e
          reauthenticate
          retry
        end
      end

      def scrobble(track, time)
        begin
          lastfm_instance.track.scrobble(artist: track.artist, track: track.title, time: time.to_i)
        rescue Lastfm::ApiError => e
          reauthenticate
          retry
        end
      end


    end
  end
end
