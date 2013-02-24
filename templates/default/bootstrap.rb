
#require "net/http"
#require "net/https"
#require "uri"
#require 'rbconfig'

say 'Building Application with the rails-maker...'

options = {}
options[:db] = case ask('Choose the database type: [1]mysql [2]postgresql [3]sqlite ').to_i
                 when 1 then 'mysql2'
                 when 2 then 'postgresql'
                 when 3 then 'sqlite3'
                 else
                   say 'Wrong input! Using sqlite by default...'
                   'sqlite3'
               end

if options[:db] != 'sqlite3'
  options[:db_user] = ask('Enter database username..')
  options[:db_pass] = ask('Enter database password..')
end

options[:authentication] = ask('Use authentication using devise? [Yn]').downcase == 'y'
if options[:authentication]
  options[:omniauth] = ask('Include authentication using omniauth? [Yn]').downcase == 'y'
  options[:authorization] = ask('Include rolify and cancan for user authorization? [Yn]').downcase == 'y'
  if options[:authorization]
    options[:admin] = ask('Create admin role, routes and layout? [Yn]').downcase == 'y'
  end
end

files = []
files << 'git'
files << 'gemfile'
files << 'haml_generator'
files << 'rails_clean'
files << 'application_layout'
files << 'home_controller'
files << 'css'
files << 'test_suite'
files << 'authentication' if options[:authentication]
files << 'authorization' if options[:authorization]
files << 'admin' if options[:admin]
files << 'db'
files << 'routes'

files.each do |file|
  apply File.expand_path("../lib/#{file}.rb", __FILE__)
end

login_as_admin_message = options[:admin] ? 'Login to admin with email admin@local.host and password admin123' : ''

say <<-D

  ########################################################################

  The rails-maker just added like 6 hours to your life.

  Template Installed :: Default

  Next run...

  rake spec
  rails s

  #{login_as_admin_message}

  ########################################################################
D

=begin
def get_remote_https_file(source, destination)
  uri = URI.parse(source)
  http = Net::HTTP.new(uri.host, uri.port)
  http.use_ssl = true
  http.verify_mode = OpenSSL::SSL::VERIFY_NONE
  request = Net::HTTP::Get.new(uri.request_uri)
  response = http.request(request)
  path = File.join(destination_root, destination)
  File.open(path, "w") { |file| file.write(response.body) }
end
=end