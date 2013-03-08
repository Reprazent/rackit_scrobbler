module RackitScrobbler
  class Player
    attr_accessor :current_track, :last_fm, :track_started_time, :progressbar

    def initialize(last_fm_client)
      @last_fm = last_fm_client
    end

    def playing
      last_fm.playing(current_track)
      puts "Playing #{current_track}"
    end
    alias_method :resume, :playing

    def paused
      puts "Paused #{current_track}"
    end

    def start
      progressbar = ProgressBar.create
      track_started_time = Time.now
      playing
    end

    def ping(percentage)
      if percentage > 0.30
        last_fm.scrobble(current_track, track_started_time)
        puts "Scrobbled #{current_track}"
      end
      progressbar.progress = percentage * 100
    end

  end

end
