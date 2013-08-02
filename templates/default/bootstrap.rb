say 'Building Application with the rails-maker...'

files = []
files << 'general'
files << 'git'
files << 'db'
files << 'gemfile'
files << 'initializers'
files << 'simple_routes'
files << 'public_layout'
files << 'admin_part'

files.each do |file|
  apply File.expand_path("../lib/#{file}.rb", __FILE__)
end

## INITIAL COMMIT
# git add: "."
# git commit: "-a -m 'Initial commit'"
 
## FURTHER INSTRUCTIONS
say <<-D

  ########################################################################

  The rails-maker just added like 6 hours to your life.

  Next:
  1 - copy content of config/example-databse.yml to config/database.yml; write your username and password for database access, write your database names or leave default for all environments in database.yml
  2 - write your secret, public keys and appid in initializers/raven.rb
  3 - generate and copy newrelic.yml file to config directory
  4 - in terminal change your directory to application root
  5 - run 'rake db:create'
  6 - run 'rails generate devise:install' and 'rails generate devise User'
  7 - run 'rake db:migrate'
  8 - run 'rails s' from your project directory

  ########################################################################
D