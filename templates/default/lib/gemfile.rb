db_gem = case options[:db]
        when 'mysql2'
          'mysql2'
        when 'postgresql'
          'pg'
        else
          'sqlite3'
        end

auth_gems = {}
if options[:authentication]
  auth_gems[:authentication] = "gem 'devise'\n"
  if options[:omniauth]
    auth_gems[:omniauth] = "gem 'omniauth-facebook', '1.4.0'\ngem 'omniauth-vkontakte'"
  end

  if options[:authorization]
    auth_gems[:authorization] = "gem 'rolify'\ngem 'cancan'\n"
  end
end

run 'rm Gemfile'
create_file 'Gemfile' do
<<-RUBY
source 'http://rubygems.org'

gem 'rails', :git => 'git://github.com/rails/rails.git', :branch => '3-2-stable'

## Database
gem '#{db_gem}'

## Server
gem 'unicorn'
gem 'psych'

## Some helpers
gem 'thor'
gem 'state_machine'
gem 'yajl-ruby'
gem 'babosa'
gem 'kaminari'
gem 'sanitize'
gem 'awesome_print'
gem 'progressbar'
gem 'unicode'
#gem 'simple_form'
#gem 'tinymce-rails'
#gem 'faraday'
#gem 'faraday_middleware'
#gem 'patron'
#gem 'certified'
#gem 'sentry-raven', :git => 'https://github.com/getsentry/raven-ruby.git'

## Frontend stuff
gem 'haml-rails'
gem 'jquery-rails'
#gem 'coffee-script'

## Uploads management
gem 'carrierwave'
gem 'rmagick'

## Authentication & Socials

#{auth_gems[:authentication]}
#{auth_gems[:authorization]}
#{auth_gems[:omniauth]}
#gem 'fb_graph'

group :assets do
  gem 'sass-rails'
  gem 'compass-rails'
  gem 'turbo-sprockets-rails3'
  gem 'uglifier'
  gem 'therubyracer'
  gem 'execjs'
  gem 'coffee-rails'
end

group :development do  
  gem 'letter_opener'
  gem 'annotate'
  gem 'ffaker'

  ## Server
  gem 'thin'
  gem 'foreman'
  gem 'mongrel', '1.2.0.pre2'
  gem 'mina'
  
  ## Deployment
  gem 'capistrano'
  gem 'capistrano-ext'
  gem 'capistrano_colors'
  gem 'rvm-capistrano'
end

group :development, :test do
  gem 'rspec-rails'
  gem 'factory_girl_rails'
end

RUBY
end

run 'bundle install'