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


## Guardfile

```ruby
guard :unicorn, :daemonized => true, :config_file => "config/unicorn.rb", :pid_file => "tmp/pids/unicorn.pid"
```
