require "rackit_scrobbler/version"
require "rackit_scrobbler/last_fm"
require "rackit_scrobbler/last_fm/client"
require "rackit_scrobbler/last_fm/authenticator"
require "rackit_scrobbler/configuration"

module RackitScrobbler
  class << self

    def config
      @config ||= Configuration.new
    end

  end
end
