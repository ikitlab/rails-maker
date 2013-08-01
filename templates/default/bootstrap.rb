
#require "net/http"
#require "net/https"
#require "uri"
#require 'rbconfig'

say 'Building Application with the rails-maker...'

files = []
files << 'general'
files << 'git'
files << 'gemfile'
files << 'db'
files << 'application_layout'
#files << 'home_controller'
files << 'css'
#files << 'test_suite'
#files << 'authentication'
#files << 'authorization'
#files << 'admin'
files << 'routes'
files << 'initializers'

files.each do |file|
  apply File.expand_path("../lib/#{file}.rb", __FILE__)
end

## INITIAL COMMIT
git add: "."
git commit: "-a -m 'Initial commit'"
 
## FURTHER INSTRUCTIONS 
say <<-D

  ########################################################################

  The rails-maker just added like 6 hours to your life.

  Next:
  1 - copy content of config/example-databse.yml to config/database.yml
  2 - write your username and password for database access, write your database names or leave default for all environments in database.yml
  3 - run 'rake db:create'
  4 - write your secret, public keys and appid in initializers/raven.rb
  5 - generate and copy newrelic.yml file to config directory
  6 - run 'rails s' from your project directory

  Login to admin with email admin@local.host and password admin123

  ########################################################################
D