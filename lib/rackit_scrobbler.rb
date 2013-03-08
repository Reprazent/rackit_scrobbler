require "active_support/all"
require "rackit_scrobbler/version"
require "rackit_scrobbler/last_fm"
require "rackit_scrobbler/last_fm/client"
require "rackit_scrobbler/last_fm/authenticator"
require "rackit_scrobbler/configuration"
require "rackit_scrobbler/rackit"
require "rackit_scrobbler/player"
require "rackit_scrobbler/track"



module RackitScrobbler
  class << self

    def config
      @config ||= Configuration.new
    end

  end
end
