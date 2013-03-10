require "minitest/autorun"
require 'mocha/api'
require "tempfile"

begin
  # [turn](http://rubygems.org/gems/turn)
  require 'turn/autorun'
rescue LoadError
end

$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

require 'rackit_scrobbler'

FAKE_CONFIG = "#{File.dirname(__FILE__)}/fixtures/config"

class MiniTest::Spec
  before do
    RackitScrobbler::Configuration.stubs(:config_path).returns(FAKE_CONFIG)
  end
end
