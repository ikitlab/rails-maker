require 'hpricot'
require 'ruby_parser'

say "Building authentication"

# Configure sensitive parameters which will be filtered from the log file.
gsub_file 'config/application.rb', /:password/, ':password, :password_confirmation'

run 'rails generate devise:install'
# Generate devise views
run 'rails generate devise:views -e erb'
# Convert devise views to haml
run "for i in `find app/views/devise -name '*.erb'` ; do html2haml -e $i ${i%erb}haml ; rm $i ; done"

gsub_file 'config/environments/development.rb', /# Don't care if the mailer can't send/, '### ActionMailer Config'

gsub_file 'config/environments/development.rb', /config.action_mailer.raise_delivery_errors = false/ do
<<-RUBY
  config.action_mailer.default_url_options = { :host => '0.0.0.0:3000' }
  config.action_mailer.delivery_method = :letter_opener
  config.action_mailer.raise_delivery_errors = false
  config.action_mailer.default :charset => "utf-8"
RUBY
end

inject_into_file 'config/environments/test.rb', :after => "config.action_controller.allow_forgery_protection    = false\n" do
<<-RUBY
  config.action_mailer.default_url_options = { :host => '0.0.0.0:3000' }
RUBY
end

gsub_file 'config/environments/production.rb', /config.i18n.fallbacks = true/ do
<<-RUBY
  config.i18n.fallbacks = true
  config.action_mailer.default_url_options = { :host => 'yourhost.com' }
  ### ActionMailer Config
  # Setup for production - deliveries, no errors raised
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.perform_deliveries = true
  config.action_mailer.raise_delivery_errors = false
  config.action_mailer.default :charset => "utf-8"
RUBY
end

run 'rails generate devise User'

apply File.expand_path("../authentication/user_model.rb", __FILE__)
apply File.expand_path("../authentication/user_auth_model.rb", __FILE__)
#apply File.expand_path("../authentication/migrations.rb", __FILE__)

generate(:migration, "AddNameToUsers name:string")
generate(:migration, "AddDeletedAtToUsers deleted_at:datetime")



if options[:omniauth]
  apply File.expand_path("../authentication/omniauth.rb", __FILE__)
end

apply File.expand_path("../authentication/header_login_items.rb", __FILE__)

run 'rm app/controllers/application_controller.rb'
create_file 'app/controllers/application_controller.rb' do
<<-RUBY
class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authenticate_user!
end
RUBY
end

append_file 'db/seeds.rb' do
<<-FILE
# Setup initial user so we can get in
user = User.create! :name => "admin", :email => "admin@local.host", :password => "admin123", :password_confirmation => "admin123"
user.confirmed_at = user.confirmation_sent_at

user.save
FILE
end
