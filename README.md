The rails-maker
===========
Generate a Rails 3 app with the application templates Quick Left uses to start their projects off right!


### What you get

The rails-maker provides a set of templates to generate Rails 3 applications.
Everything is configured and ready to rock your next Rails 3 project.
We hope it saves you a mess of time!

* Default: A base Rails 3 application with Devise and Cancan for
  authentication and authorization. Roles are stored in the database
  with a HABTM relationship between the role and user models. You also get
  a basic admin to manage users. The rails-maker also rolls in all of the things
  we like to have setup in our apps like: haml, sass, jquery, cucumber,
  capybara, mocha, factory_girl, rspec, timecop, autotest, evergreen,
  jasmine, will_paginate, friendly_id and hoptoad_notifier.

        rails-maker new my_app
        rails-maker new my_app default

* Async: A Rails 3 application with the basic setup complete for running
  fully async on the Thin web server. Included gems are thin,
  rack-fiber_pool, mysql2, and rspec.

        rails-maker new my_app async

* Base: A Rails application with the basic setup of gems, including newrelic, sidekiq, raven.l2, and rspec.

        rails-maker new my_app base


### Quick Start

    gem install rails-maker

    rails-maker new my_app


### Options ( in default template )

    rails-maker new my_app --no-auth

    rails-maker new my_app --no-roles

    rails-maker new my_app --no-admin


### Testing generated default app

    rake spec
    rake cucumber
    rake spec:javascripts
    bundle exec autotest


### Issues

Please report issues to the [the rails-maker issue tracker](http://github.com/koteus/rails-maker/issues/).


### Development

    bundle install
    bundle exec cucumber

Running `bundle exec cucumber` will take some time.  It runs the CLI tool with different option combinations and tests
those outputs with aruba.


### Patches/Pull Requests

* Fork it.
* Add tests for it.
* Make your changes.
* Commit.
* Send a pull request.


### Thanks

All of the contributors to the many awesome open source projects that make up rails-maker and allow us to do our job everyday.
Also, thanks go out to the crew at thoughtbot for writing suspenders.  It's what gave us the idea to package up our
templates into a gem in the first place.


### Copyright

Copyright (c) 2010-2011 Collin Schaafsma & Quick Left. See LICENSE for details.

