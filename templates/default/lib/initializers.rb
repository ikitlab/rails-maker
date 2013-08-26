say '## INITIALIZERS/CONFIGS >>'
 
initializer 'raven.rb', <<-END
require 'raven'
 
Raven.configure do |config|
  config.dsn = 'https://secret:public@app.getsentry.com/appid'
end
END

# create_file 'config/sidekiq.yml', <<-END
#   ---
#   :concurrency: 5
#   :pidfile: tmp/pids/sidekiq.pid
#   staging:
#     :concurrency: 10
#   production:
#     :concurrency: 50
# END
