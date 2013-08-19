say '## CAPISTRANOS >>'

run 'capify .'

run "rm config/deploy.rb"
create_file 'config/deploy.rb', <<-END
  set :application, '#{app_name}'
  set :repository,  "your-git-address-repository"

  role :web, "your-server-address"
  role :app, "your-server-address"
  role :db,  "your-server-address", primary: true

  set :user, '#{app_name}'
  set :password, "your-project-user-password"

  set :deploy_to, "/home/\#{user}/apps/\#{application}/"

  set :db_adapter, "postgresql"
  set :db_pool, 100
  set :db_database, '#{app_name}_production'
  set :db_host, 'your-server-address'

  set :db_user, '#{app_name}'
  set :db_password, 'your-database-user-password'

  set :server_name, "your-server-address-or-domain-name"

  require "rvm/capistrano"
  require 'bundler/capistrano'
  require 'sidekiq/capistrano'

  set :sidekiq_pid, "\#{current_path}/pids/sidekiq.pid"
END

append_file 'Capfile', "\nrequire 'crecipes'\n"