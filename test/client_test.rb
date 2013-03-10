require "helper"
describe RackitScrobbler::LastFm::Client do

  it "should see if it is authenticated" do
    client = RackitScrobbler::LastFm::Client.new(nil)
    assert !client.authenticated?
    client.lastfm_instance.session = "a session token"
    assert client.authenticated?
  end

  it "can set the playing state for a song" do
    client = RackitScrobbler::LastFm::Client.new("token")
    track_obj = Object.new
    client.lastfm_instance.expects(:track).returns(track_obj)
    track_obj.expects(:update_now_playing).with(artist: "Crazy Flippo's", track: "Nasty beat groove")
    client.playing(OpenStruct.new(artist: "Crazy Flippo's", title: "Nasty beat groove"))
  end

  it "can scrobble a song" do
    client = RackitScrobbler::LastFm::Client.new("token")
    track_obj = Object.new
    client.lastfm_instance.expects(:track).returns(track_obj)
    time = Time.now
    track_obj.expects(:scrobble).with(artist: "Crazy Flippo's", track: "Nasty beat groove", time: time.to_i)
    track = OpenStruct.new(artist: "Crazy Flippo's", title: "Nasty beat groove")
    client.expects(:playing).with(track)
    client.scrobble(track, time)

  end


end
