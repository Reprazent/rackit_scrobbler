require "lastfm"

module RackitScrobbler
  module LastFm
    class << self
      def config
        raise "set last fm api key" unless RackitScrobbler.config.last_fm.api_key
        raise "set last fm api secret" unless RackitScrobbler.config.last_fm.api_secret
        RackitScrobbler.config.last_fm
      end
    end
  end
end
