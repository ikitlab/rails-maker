$:.unshift File.expand_path("../lib", __FILE__)
require "rails-maker/version"

Gem::Specification.new do |gem|
  gem.name    = 'rails-maker'
  gem.version = RailsMaker::VERSION

  gem.author      = 'Konstantin Kalbazov'
  gem.email       = 'kalbazov@gmail.com'
  gem.homepage    = 'http://github.com/koteus/rails-maker'
  gem.summary     = "rails-maker-#{s.version}"
  gem.description = 'Generate a Rails app with application templates'
  gem.executables = 'rails-maker'
  gem.license     = 'MIT'
  
  gem.files = %x{ git ls-files }.split("\n").select { |d| d =~ %r{^(License|README|bin/|data/|ext/|lib/|spec/|test/)} }

  # Runtime Dependencies
  s.add_dependency "activesupport"
  s.add_dependency "thor"
  s.add_dependency "rails"

  # Development Dependencies
  s.add_development_dependency "bundler"
  s.add_development_dependency "rspec"
  s.add_development_dependency "thor"
end