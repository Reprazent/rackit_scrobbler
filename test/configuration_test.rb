require "helper"
describe RackitScrobbler::Configuration do

  it "can load the config file" do
    fake = YAML::load_file(FAKE_CONFIG)
    fake.inspect
    assert_equal fake, RackitScrobbler::Configuration.new.config_file
  end

  it "has an empty config when the file does not exist" do
    RackitScrobbler::Configuration.expects(:config_path).returns("/non/existant")
    assert_equal Hash.new, RackitScrobbler::Configuration.new.config_file
  end

  it "can read the last fm configuration" do
    c = RackitScrobbler::Configuration.new
    assert_equal "last fm key", c.last_fm.api_key
    assert_equal "last fm secret", c.last_fm.api_secret
    assert_equal "session_token", c.last_fm.session_token
  end

  it "can read the rackit configuration" do
    c = RackitScrobbler::Configuration.new
    assert_equal "ws://localhost:13581", c.rackit.rackmate_socket
  end

end
