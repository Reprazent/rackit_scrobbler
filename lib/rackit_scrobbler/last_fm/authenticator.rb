require "launchy"
module RackitScrobbler
  module LastFm
    class Authenticator

      attr_accessor :last_fm
      def initialize(last_fm)
        @last_fm = last_fm
      end

      def session_key
        unless config.session_key
          config.session_key = new_session_key
          RackitScrobbler.config.write!
        end
        config.session_key
      end

      def new_session_key
        token = last_fm.auth.get_token
        Launchy.open("http://www.last.fm/api/auth/?api_key=#{config.api_key}&token=#{token}" )
        puts "Press any key to continue after you've granted access"
        response = STDIN.gets.chomp
        last_fm.auth.get_session(:token => token)["key"]
      end

      def config
        LastFm.config
      end

    end
  end
end
