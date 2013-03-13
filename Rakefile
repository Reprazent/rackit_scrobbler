require "bundler/gem_tasks"
require 'rake/testtask'

desc 'Run rackitscrobbler unit tests.'
Rake::TestTask.new(:test) do |t|
  t.libs << 'lib'
  t.libs << 'test'
  t.pattern = 'test/**/*_test.rb'
  t.verbose = true
end

task :default => :test

desc "Open an pry session with Potemkin loaded"
task :console do
  sh "pry -I lib -r rackit_scrobbler.rb"
end

desc "start"
task :start do
  require "rackit_scrobbler"
  last_fm_client = RackitScrobbler::LastFm::Client.new(RackitScrobbler.config.last_fm.session_key)
  player = RackitScrobbler::Rackit::Listener.new(last_fm_client)
  listener = RackitScrobbler::Rackit::Rackmate.new(player)
  listener.start_rackmate
end

desc "creates the config file"
task :config do
  require "rackit_scrobbler"
  RackitScrobbler.config.last_fm.api_key = "57572cbb1e0f50ffe2caffe88c2e9888"
  RackitScrobbler.config.last_fm.api_secret = "dc0f9f9eeb17d19fea2d1d5d8256bb31"
  RackitScrobbler.config.rackit.rackmate_socket = "ws://localhost:13581"
  RackitScrobbler.config.write!
end
