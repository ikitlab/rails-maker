### FILES FOR REMOVE
run 'rm public/index.html'
run 'rm public/images/rails.png'
run 'rm README'
run 'rm README.rdoc'
run 'rm public/favicon.ico'
file 'README.md', <<-FILE
#{ARGV[0].humanize}
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
  database: dev_#{ARGV[0].underscore}

test:
  <<: *defaults
  database: test_#{ARGV[0].underscore}

production:
  <<: *defaults
  database: prod_#{ARGV[0].underscore}
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

gem_group :assets do
  gem 'sass-rails'
  gem 'compass-rails'
  gem "uglifier"
  gem 'coffee-rails'
  gem 'jquery-rails'
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
prepend_file 'config/routes.rb', "require 'sidekiq/web'\n"
route "mount Sidekiq::Web, at: '/sidekiq'"

## INITIAL COMMIT
git add: "."
git commit: "-a -m 'Initial commit'"

## FURTHER INSTRUCTIONS
say <<-D

  Next:
  1 - copy content of config/example-databse.yml to config/database.yml
  2 - write your username and password for database access, write your database names or leave default for all environments in database.yml
  3 - run 'rake db:create'
  4 - write your secret, public keys and appid in initializers/raven.rb
  5 - generate and copy newrelic.yml file to config directory
  6 - run 'rails s' from your project directory

D