
#require "net/http"
#require "net/https"
#require "uri"
#require 'rbconfig'

say 'Building Application with the rails-maker...'

files = []
files << 'git'
files << 'gemfile'
files << 'rails_clean'
files << 'application_layout'
files << 'home_controller'
files << 'css'
files << 'test_suite'
files << 'authentication'
files << 'authorization'
files << 'admin'
files << 'db'
files << 'routes'

files.each do |file|
  apply File.expand_path("../lib/#{file}.rb", __FILE__)
end

say <<-D

  ########################################################################

  The rails-maker just added like 6 hours to your life.

  Template Installed :: Default

  Next run...

  rake spec
  rails s

  'Login to admin with email admin@local.host and password admin123'

  ########################################################################
D