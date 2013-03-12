require "active_support/all"
module RackitScrobbler
  class Track
    attr_accessor :artist, :title, :album, :route, :partner_id, :duration, :scrobbled, :genres
    def initialize(params = {})
      params.keys.each do |k|
        send("#{k.underscore}=", params[k])
      end
    end

    def to_s
      "#{artist}: #{album} - #{title}"
    end

  end
end
