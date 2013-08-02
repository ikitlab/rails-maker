### FILES FOR REMOVE
run 'rm public/index.html'
run 'rm public/images/rails.png'
run 'rm README'
run 'rm README.rdoc'
run 'rm public/favicon.ico'
file 'README.md', <<-FILE
#{app_name.humanize}
===========
FILE
run 'mkdir app/workers'
run 'mkdir app/uploaders'

### GIT
git :init

run "rm .gitignore"
file '.gitignore', <<-END
# Ignore bundler config
/.bundle

# Ignore the default SQLite database.
/db/*.sqlite3

config/database.yml

# Ignore all logfiles and tempfiles.
/log/*.log
/tmp

/public/uploads
/public/assets

# Ignore Rubymine project files
.idea/

# Ignore Ctags file
.tags

.rvmrc
.zeus.sock
.DS_Store
public/system/**/**/**/*
.sass-cache/**/*
*.swp

# Ignore sublime workspace files
*.sublime-project
*.sublime-workspace
END

file 'config/example-databse.yml', <<-END
defaults: &defaults
  adapter: postgresql
  encoding: unicode
  pool: 25
  username: username
  password: password
  host: localhost

development:
  <<: *defaults
  database: dev_#{app_name.underscore}

test:
  <<: *defaults
  database: test_#{app_name.underscore}

production:
  <<: *defaults
  database: prod_#{app_name.underscore}
END

### GEMS
run "rm Gemfile"
file 'Gemfile'

add_source 'https://rubygems.org'

gem 'rails'
## database gem
gem 'pg'
## form builder
gem 'simple_form'
## yml settings for app
gem 'settingslogic'
## pagination
gem 'kaminari'

gem 'state_machine'
## templates language
gem 'haml'

gem 'wirble'
gem 'letter_opener'
gem 'meta_request'
## authentication
gem 'devise'
## authorization
gem 'cancan'
## image uploading
gem 'carrierwave'

gem 'progressbar'
gem 'awesome_print'
## error catching
gem "sentry-raven", :git => "https://github.com/getsentry/raven-ruby.git", :require => "raven"
## background processing
gem "sidekiq"
gem "sinatra", require: false
gem "slim"
### monitoring
gem 'newrelic_rpm'
gem 'turbolinks'

gem 'coffee-rails'
gem 'jquery-rails'
gem 'sass-rails'
gem 'bootstrap-sass'
gem_group :assets do 
  gem 'compass-rails'
  gem "uglifier"
end

gem_group :development do
  ## better console
  gem "pry-rails"
  ## no assets in logs
  gem 'quiet_assets'
  ## development server
  gem 'thin'
  ## deploying
  gem "capistrano"
  gem "capistrano-ext"
  gem "capistrano_colors"
end

gem_group :test, :development do
  ## test gems
  gem "rspec-rails"
  gem 'factory_girl_rails'
  gem 'database_cleaner'
end

run 'bundle install'

## INITIALIZERS
initializer 'raven.rb', <<-END
require 'raven'

Raven.configure do |config|
  config.dsn = 'https://secret:public@app.getsentry.com/appid'
end
END

## ROUTES
prepend_file 'config/routes.rb', "require 'sidekiq/web'\n\n"
route "mount Sidekiq::Web, at: '/sidekiq'"

## PUBLIC LAYOUT
file 'app/views/application/_flash_messages.html.haml', <<-END
- flash.each do |key, value|
  .alert{ class: "alert-" + key.to_s }
    %button{ type: "button", class: "close", "data-dismiss" => "alert"}
      &times;
    = value
END

run 'rm app/views/layouts/application.html.erb'
file 'app/views/layouts/application.html.haml', <<-END
!!! 5
%html{ lang: I18n.locale }
  %head
    %meta{ charset: 'utf-8'}
    %title #{app_name.humanize}
    = csrf_meta_tag
    = stylesheet_link_tag "application"

  %body{ "data-locale" => I18n.locale }

    .container
      =render partial: 'flash_messages'

      = yield

    = javascript_include_tag "application"
END

## ADMIN PART
# admin javascript
gsub_file 'app/assets/javascripts/application.js', /\/\/= require_tree ./, ''
file 'app/assets/javascripts/admin.js', <<-END
//= require jquery
//= require jquery_ujs
//= require bootstrap
END
# admin stylesheet
gsub_file 'app/assets/stylesheets/application.css', /\*= require_tree ./, ''
file 'app/assets/stylesheets/admin.css.scss', <<-END
@import "bootstrap";
END
inject_into_file 'config/application.rb', after: "class Application < Rails::Application\n" do
  "\n    config.assets.precompile += ['admin.css.scss']\n\n"
end
# admin base controller
run 'mkdir "app/controllers/admin"'
create_file 'app/controllers/admin/application_controller.rb', <<-END
class Admin::ApplicationController < ApplicationController
  layout 'admin'
  before_filter :authenticate_user!
  before_filter :verify_admin

  private

  def verify_admin
    redirect_to root_url unless current_user.admin?
  end
end
END
# admin layout with menu, flash messages
run 'mkdir app/views/admin'
run 'mkdir app/views/admin/application'

file 'app/views/admin/application/_header.html.haml', <<-END
.navbar.navbar-fixed-top
  .navbar-inner
    .container
      %a.btn.btn-navbar{ "data-target" => ".nav-collapse", "data-toggle" => "collapse" }
        %span.icon-bar
        %span.icon-bar
        %span.icon-bar
      %a.brand{ href: root_path } #{app_name.humanize}
      .nav-collapse
        =render partial: 'navigation_menu'
END

file 'app/views/admin/application/_flash_messages.html.haml', <<-END
- flash.each do |key, value|
  .alert{ class: "alert-" + key.to_s }
    %button{ type: "button", class: "close", "data-dismiss" => "alert"}
      &times;
    = value
END

file 'app/views/admin/application/_footer.html.haml'

file 'app/views/admin/application/_navigation_menu.html.haml', <<-END
%ul.nav
  %li= link_to "Dashboard", admin_root_path
END

file 'app/views/layouts/admin.html.haml', <<-END
!!! 5
%html{ lang: I18n.locale }
  %head
    %meta{ charset: 'utf-8'}
    %title #{app_name.humanize} - AdminPanel
    = csrf_meta_tag
    = stylesheet_link_tag "admin"

  %body{ "data-locale" => I18n.locale }

    =render partial: 'header'

    .container
      =render partial: 'flash_messages'

      = yield

    = javascript_include_tag "admin"
END
# admin namespace in routes
inject_into_file 'config/routes.rb', after: "mount Sidekiq::Web, at: '/sidekiq'" do
  <<-END
  \n
  namespace :admin do
    \n
  end
  END
end
# add cancan ability with admin can manage all
file 'app/models/ability.rb', <<-END
class Ability
  include CanCan::Ability

  def initialize(user)
    if user.admin?
      can :manage, :all
    end
  end
end
END

## FURTHER INSTRUCTIONS
say <<-D

  Next:
  1 - copy content of config/example-databse.yml to config/database.yml; write your username and password for database access, write your database names or leave default for all environments in database.yml
  2 - write your secret, public keys and appid in initializers/raven.rb
  3 - generate and copy newrelic.yml file to config directory
  4 - in terminal change your directory to application root
  5 - run 'rake db:create'
  6 - run 'rails generate devise:install' and 'rails generate devise User'
  7 - run 'rake db:migrate'
  8 - run 'rails s' from your project directory

D