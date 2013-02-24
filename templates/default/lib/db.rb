
say "db: #{options[:db]}, user: #{options[:db_user]}, pass: #{options[:db_pass]}"
say "authentication: #{options[:authentication]}, omniauth: #{options[:omniauth]}, authorization: #{options[:authorization]}, admin: #{options[:admin]}"

run 'rm config/database.yml'

create_file 'config/database.yml' do
<<-RUBY
common: &common
  host: localhost
  adapter: #{options[:db]}
  encoding: utf8
  username: #{options[:db_user]}
  password: #{options[:db_pass]}

development:
  <<: *common
  database: #{app_name.downcase}_development

test:
  <<: *common
  database: #{app_name.downcase}_test

production:
  <<: *common
  database: #{app_name.downcase}_production
RUBY
end

run 'rake db:migrate'
run 'rake db:seed' if options[:admin]
run 'rake db:test:prepare'