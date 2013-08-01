say '## GEMFILE >>'

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