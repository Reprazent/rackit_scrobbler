source 'https://rubygems.org'

gemspec

group :development do
  # An IRB alternative and runtime developer console
  # [pry](http://pry.github.com)
  gem 'pry', '~> 0.9.10'
  # Using guard to run the tests autmoatically on file change.
  # Just run `guard` in the root of the folder
  #
  # [guard](https://github.com/guard/guard)
  gem 'guard', '~> 1.5.0'

end

group :test do
  # Adding rake for Travis.
  gem 'rake'

  # minitest provides a complete suite of testing facilities...
  # [minitest](https://github.com/seattlerb/minitest)
  gem 'minitest'

  # Adds color to your MiniTest output
  gem "minitest-rg", "~> 1.0.0"

  # [mocha](http://gofreerange.com/mocha/docs)
  gem 'mocha', '~> 0.13.0'

  gem 'guard-minitest'
end

# Workaround for Heroku:
# [More info](http://www.johnplummer.com/rails/heroku-error-conditional-rbfsevent-gem.html)
group :test, :darwin do
  # OS X
  gem 'terminal-notifier-guard'
  gem 'rb-fsevent', :require => false
end
