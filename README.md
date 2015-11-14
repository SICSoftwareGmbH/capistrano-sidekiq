[![Gem Version](https://img.shields.io/gem/v/capistrano-sidekiq-sic.svg)](https://rubygems.org/gems/capistrano-sidekiq-sic)
[![Dependencies](https://img.shields.io/gemnasium/SICSoftwareGmbH/capistrano-sidekiq.svg)](https://gemnasium.com/SICSoftwareGmbH/capistrano-sidekiq)


# Capistrano::Sidekiq

Sidekiq integration for Capistrano.


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'capistrano-sidekiq-sic'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install capistrano-sidekiq-sic


## Usage

Require in `Capfile` to use the default task:

```ruby
require 'capistrano/sidekiq'
```

Configurable options, shown here with defaults:

```ruby
set :sidekiq_roles,   :app
set :sidekiq_env,     -> { fetch(:rack_env, fetch(:rails_env, fetch(:stage))) }
set :sidekiq_user,    -> { fetch(:app_user, nil) }
set :sidekiq_log,     -> { File.join(shared_path, 'log', 'sidekiq.log') }
set :sidekiq_pid,     -> { File.join(shared_path, 'tmp', 'pids', 'sidekiq.pid') }
set :sidekiq_timeout, -> { 10 }
```


## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/SICSoftwareGmbH/capistrano-sidekiq.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
