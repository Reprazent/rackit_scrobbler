module RackitScrobbler
  module Rackit
    class Listener
      attr_accessor :current_track, :last_fm, :track_started_time

      def initialize(last_fm_client)
        @last_fm = last_fm_client
      end

      def playing
        last_fm.playing(current_track)
        puts "Playing #{current_track}"
      end
      alias_method :resume, :playing

      def pause
        puts "Paused #{current_track}"
      end

      def start
        track_started_time = Time.now
        playing
      end

      def ping(percentage)
        if current_track && (percentage > 0.30) && !current_track.scrobbled
          last_fm.scrobble(current_track, track_started_time)
          current_track.scrobbled = true
          puts "Scrobbled #{current_track}"
        end
      end

    end

  end
end
