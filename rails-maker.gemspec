$:.unshift File.expand_path("../lib", __FILE__)
require 'rails-maker/version'

Gem::Specification.new do |gem|
  gem.name    = 'rails-maker'
  gem.version = RailsMaker::VERSION

  gem.author      = 'Konstantin Kalbazov'
  gem.email       = 'kalbazov@gmail.com'
  gem.homepage    = 'http://github.com/koteus/rails-maker'
  gem.summary     = "rails-maker-#{gem.version}"
  gem.description = 'Generate a Rails app with application templates'
  gem.executables = 'rails-maker'
  gem.license     = 'MIT'
  
  gem.files = %x{ git ls-files }.split("\n").select { |d| d =~ %r{^(LICENSE|README|bin/|templates/|lib/|spec/)} }

  # Runtime Dependencies
  gem.add_dependency 'activesupport'
  gem.add_dependency 'thor'
  gem.add_dependency 'rails'

  # Development Dependencies
  gem.add_development_dependency 'bundler'
  gem.add_development_dependency 'rspec'
  gem.add_development_dependency 'thor'
end