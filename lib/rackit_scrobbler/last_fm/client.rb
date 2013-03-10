require "lastfm"

module RackitScrobbler
  module LastFm
    class Client

      attr_accessor :lastfm_instance

      def authenticated?
        lastfm_instance.session
      end

      def initialize(token)
        @lastfm_instance = Lastfm.new(LastFm.config.api_key, LastFm.config.api_secret)
        @lastfm_instance.session = token
      end

      def playing(track)
          lastfm_instance.track.update_now_playing(artist: track.artist, track: track.title)
      end

      def scrobble(track, time)
        lastfm_instance.track.scrobble(artist: track.artist, track: track.title, time: time.to_i)
        playing(track)
      end


    end
  end
end
