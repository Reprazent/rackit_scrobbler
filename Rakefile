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
  last_fm_client = RackitScrobbler::LastFm::Client.new
  last_fm_client.authenticate unless last_fm_client.authenticated?
  player = RackitScrobbler::Player.new(last_fm_client)
  listener = RackitScrobbler::Rackit.new(player)
  listener.start_rackmate
end
