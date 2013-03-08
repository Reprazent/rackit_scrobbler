require "active_support/all"
module RackitScrobbler
  class Track
    attr_accessor :artist, :title, :album, :route, :partner_id, :duration
    def initialize(params = {})
      params.keys.each do |k|
        send("#{k.underscore}=", params[k])
      end
    end

  end
end
