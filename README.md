# Spree Awesome! Blog

[![Build Status](https://secure.travis-ci.org/futhr/spree-awesome-blog.png?branch=master)](http://travis-ci.org/futhr/spree-awesome-blog)
[![Dependency Status](https://gemnasium.com/futhr/spree-awesome-blog.png)](https://gemnasium.com/futhr/spree-awesome-blog)
[![Coverage Status](https://coveralls.io/repos/futhr/spree-awesome-blog/badge.png?branch=master)](https://coveralls.io/r/futhr/spree-awesome-blog)

Awesome! minimalistic blog for Spree. It use markdown instead of html so no images or media are stored but linked.

**WIP**

_Note: Its a heavy refactor from the previous version so I doubt its upgradable._

## TODO

**high prio**

* add factories and fix mass-assign protected attributes in tests
* fix rest of port from older version
* update all views
* fix override so its hooked into admin
* fix assets
* apply [epiceditor][1] or cleaner like [jbt.gihub.io markdown-editor][7]
* fix tests
* remove locale keys that exists already in spree core
* change to strong_parameters gem so its more rails4 ready

**features**

* add ability decorator with tests
* add preferences to customize markdown editor
* better caching of posts and assets
* pingback
* social share (responsive and retina ready font icons)
* make it more html5ish

**if you wanna do it**

* make it upgradable from previous versions
* add other neat fatures

## Installing

Add spree_awesome_blog to your `Gemfile`:
```ruby
gem 'spree_awesome_blog', github: 'futhr/spree-awesome-blog'
```

Run bundler

    bundle install

Install migrations & initializer file

    bundle exec rails g spree_awesome_blog:install

## Contributing

In the spirit of [free software][2], **everyone** is encouraged to help improve this project.

Here are some ways *you* can contribute:

* by using prerelease versions
* by reporting [bugs][3]
* by suggesting new features
* by writing [translations][4]
* by writing or editing documentation
* by writing specifications
* by writing code (*no patch is too small*: fix typos, add comments, clean up inconsistent whitespace)
* by refactoring code
* by resolving [issues][3]
* by reviewing patches

Starting point:

* Fork the repo
* Clone your repo
* Run `bundle install`
* Run `bundle exec rake test_app` to create the test application in `spec/test_app`
* Make your changes and follow this [Style Guide][5]
* Ensure specs pass by running `bundle exec rspec spec`
* Submit your pull request

Copyright (c) 2013 Josh Nussbaum, Tobias Bohwalli, released under the [New BSD License][6]

[1]: http://epiceditor.com
[2]: http://www.fsf.org/licensing/essays/free-sw.html
[3]: https://github.com/futhr/spree-awesome-blog/issues
[4]: https://localeapp.com
[4]: https://github.com/thoughtbot/guides
[6]: https://github.com/futhr/spree-awesome-blog/tree/master/LICENSE
[7]: http://jbt.github.io/markdown-editor
