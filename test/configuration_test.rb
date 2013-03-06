require "helper"
describe RackitScrobbler::Configuration do

  it "can load the config file" do
    RackitScrobbler::Configuration.expects(:config_path).returns(FAKE_CONFIG)
    assert_equal YAML::load_file(FAKE_CONFIG), RackitScrobbler::Configuration.new.config_file
  end

  it "has an empty config when the file does not exist" do
    assert_equal Hash.new, RackitScrobbler::Configuration.new.config_file
  end

  it "can create the last fm configuration" do
    RackitScrobbler::Configuration.expects(:config_path).returns(FAKE_CONFIG)
    c = RackitScrobbler::Configuration.new
    assert_equal "last fm key", c.last_fm.api_key
    assert_equal "last fm secret", c.last_fm.api_secret
    assert_equal "session_token", c.last_fm.session_token
  end

  it "can create the last_fm configuration" do
    RackitScrobbler::Configuration.expects(:config_path).returns(FAKE_CONFIG)
    c = RackitScrobbler::Configuration.new
    assert_equal "rackit user", c.rackit.user
    assert_equal "rackit pass key", c.rackit.pass_key
    assert_equal "rackit email", c.rackit.email

  end

end
