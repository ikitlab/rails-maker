say '## DB >>'

run 'rm config/database.yml'

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