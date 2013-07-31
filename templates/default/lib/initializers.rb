 ## INITIALIZERS
 
initializer 'raven.rb', <<-END
require 'raven'
 
Raven.configure do |config|
  config.dsn = 'https://secret:public@app.getsentry.com/appid'
end
END