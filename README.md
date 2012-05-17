# Guard::Unicorn [![Build Status](https://secure.travis-ci.org/xhr/guard-unicorn.png)](http://travis-ci.org/#!/xhr/guard-unicorn)

`Guard::Unicorn` automatically restarts the Unicorn server using [Guard] [gu].

[gu]: https://github.com/guard/guard


## Installation

Using Rubygems:

    $ gem install guard-unicorn

Using Bundler, add this to your `Gemfile`, preferably in the `development` group:

```ruby
group :development
  gem 'guard-unicorn'
end
```

Add a sample Guard definition to your `Guardfile`:

    $ guard init unicorn


## Guard General Usage

Please read the [guard usage doc] [gd] in order to find out more about Guard and 
how to use Guards. There is also [a Railscast about Guard] [gc], created by Ryan
Bates.

[gd]: https://github.com/guard/guard/blob/master/README.md
[gc]: http://railscasts.com/episodes/264-guard

It is recommended that you also install the [ruby-gntp] [gntp] on Mac OS X,
[libnotify] [ln] on Linux, FreeBSD or Solaris or [rb-notifu] [notifu] in order
to have graphical notifications.

[gntp]: https://rubygems.org/gems/ruby_gntp
[ln]: https://rubygems.org/gems/libnotify
[notifu]: https://rubygems.org/gems/rb-notifu


## Guardfile for guard-unicorn

```ruby
guard :unicorn, :daemonized => true
```

Available options:

* `:daemonized` run the Unicorn server as a daemon. Can be `true` or `false`.
  Defaults to `false`
* `:bundler` use `bundle exec` to start Unicorn. Defaults to `true`.
* `:config_file` path to the Unicorn config file. Defaults to
  `config/unicorn.rb`
* `:pid_file` path to the Unicorn PID file. Defaults to `tmp/pids/unicorn.pid`
* `:preloading` is Unicorn configured to preload the application? Defaults to
  `false`.
* `:port` on what port to run Unicorn. Defaults to `3000`.
