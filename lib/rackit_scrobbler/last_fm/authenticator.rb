require "launchy"
module RackitScrobbler
  module LastFm
    class Authenticator

      attr_accessor :last_fm
      def initialize(last_fm)
        @last_fm = last_fm
      end

      def session_key(refresh = false)
        if !config.session_key || refresh
          config.session_key = new_session_key
          RackitScrobbler.config.write!
        end
        config.session_key
      end

      def new_session_key
        token = last_fm.auth.get_token
        begin
          key = last_fm.auth.get_session(:token => token)["key"]
        rescue
          Launchy.open("http://www.last.fm/api/auth/?api_key=#{config.api_key}&token=#{token}" )
          wait_for_user
          retry
        end
        key
      end

      def wait_for_user
        puts "Press any key to continue after you've granted access"
        STDOUT.flush
        response = STDIN.gets.chomp
      end

      def config
        LastFm.config
      end

    end
  end
end
