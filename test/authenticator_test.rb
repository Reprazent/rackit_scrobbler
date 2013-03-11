require "helper"

describe RackitScrobbler::LastFm::Authenticator do
  before do
    @auth = OpenStruct.new
    @last_fm = OpenStruct.new(auth: @auth)
    @authenticator = RackitScrobbler::LastFm::Authenticator.new(@last_fm)
  end

  it "can read the session key from the config"do
    @authenticator.expects(:config).returns(OpenStruct.new(session_key: "key")).at_least_once
    assert_equal "key", @authenticator.session_key
  end

  it "writes a new key when there isn't one" do
    @authenticator.expects(:new_session_key).returns("new_key")
    assert_equal "new_key", @authenticator.session_key(true)
  end

  it "can get a new session key" do
    @auth.expects(:get_token).returns("token")
    @auth.expects(:get_session).with(token: "token").returns("key" => "new_key")
    assert_equal "new_key", @authenticator.new_session_key
  end

  it "can prompt access for a new key" do
    @auth.expects(:get_token).returns("token")
    @auth.expects(:get_session).with(token: "token").raises("").once
    @auth.expects(:get_session).with(token: "token").returns("key").once
    Launchy.expects(:open).with("http://www.last.fm/api/auth/?api_key=last fm key&token=token")
    @authenticator.expects(:wait_for_user)
    assert_equal "key", @authenticator.new_session_key
  end
end
