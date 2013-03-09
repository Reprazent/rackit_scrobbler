# RackitScrobbler

Scrobble music playing from [Rackit](http://rackit.co).

I really like [Rackit](http://rackit.co) for playing music. But I hate when what I listen to isn't scrobbled to [Last.fm](http://www.last.fm/user/ksorax). So I made a quick fix for that

## Installation

For now it will be a matter of cloneing:

`git clone git://github.com/Reprazent/rackit_scrobbler.git`

after that:

`bundle install`

You can create the config file with:

`bundle exec rake config`

## Usage

Make sure rackmate is running and then do a:

`bundle exec rake start`

The first time this should pop up a browser asking you to allow access to last.fm.
After that return to your terminal and hit enter to start scrobbling.

Start playing music using rackmate. It will set the now playing state on your profile ate every beginning of a song. Scrobble after you played 1/3th of the song.

The output should look something like this:

```
Playing Wolves At The Gate: Captors - Step Out of the Water
Scrobbled Wolves At The Gate: Captors - Step Out of the Water
```

## Todo

1. Set the correct song when when opening the socket. So whe can start scrobbling when started after rackmate was playing. (Now the scrobbling will start next song)
2. Catch errors when scrobbling and retry (for example when connection drops for a second).
3. Block double scrobbles (When stopping and starting scrobbler again)
4. Make it a proper gem so people can `gem install`, `rackit config` and `rackit start`. But eventmachine seems to be acting up here.
5. Maybe add some tests. I started this as a quick fix for the scrobbling problem. But had fun doing it, so I intend to use this as a play-project.
6. Suggestions? Add an [issue](https://github.com/Reprazent/rackit_scrobbler/issues)!
7. bugs? Add an [issue](https://github.com/Reprazent/rackit_scrobbler/issues)!


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
