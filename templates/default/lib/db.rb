say '## DB >>'

file 'config/example-database.yml', <<-END
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