# Guard::Santorini [![Build Status](https://secure.travis-ci.org/xhr/guard-santorini.png)](http://travis-ci.org/#!/xhr/guard-santorini)

`Guard::Santorini` automatically runs all your Rails tests using [Guard] [gu]. 
It is similar to [guard-test] [gt] except that it is supposed to work out of
the box with older Rails-based applications.

[gu]: https://github.com/guard/guard
[gt]: https://github.com/guard/guard-test


## Installation

Using Rubygems:

    $ gem install guard-santorini

Using Bundler, add this to your `Gemfile`, preferably in the `development` group:

```ruby
group :development
  gem 'guard-santorini'
end
```

Add a sample Guard definition to your `Guardfile`:

    $ guard init santorini


## Usage

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

TBD
