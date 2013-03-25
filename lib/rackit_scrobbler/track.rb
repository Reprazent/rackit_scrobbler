require "active_support/all"
module RackitScrobbler
  class Track
    attr_accessor :artist, :title, :album, :route, :partner_id, :duration, :scrobbled, :genres, :user_id, :user, :play_date, :session_id
    def initialize(params = {})
      params.keys.each do |k|
        send("#{k.underscore}=", params[k])
      end
    end

    def to_s
      "(#{user}) #{artist}: #{album} - #{title}"
    end

    def self.try_parse(params)
      self.new(params) rescue nil
    end
  end
end
