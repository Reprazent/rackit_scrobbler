# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rackit_scrobbler/version'

Gem::Specification.new do |spec|
  spec.name          = "rackit_scrobbler"
  spec.version       = RackitScrobbler::VERSION
  spec.authors       = ["Bob Van Landuyt"]
  spec.email         = ["bob.vanlanduyt@gmail.com"]
  spec.description   = %q{Gem to scrobble to last FM}
  spec.summary       = spec.description
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency 'pry', '~> 0.9.12'

  spec.add_dependency "lastfm", "~> 1.17.0"
  spec.add_dependency "launchy", "~> 2.2.0"
  spec.add_dependency 'eventmachine', '~> 1.0.1'
  spec.add_dependency 'faye-websocket', '~> 0.4.7'
  spec.add_dependency 'active_support', '~> 3.0.0'
end
