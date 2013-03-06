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

    end
  end
end
