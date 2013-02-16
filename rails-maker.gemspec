# -*- encoding: utf-8 -*-
require File.expand_path("../lib/rails-maker/version", __FILE__)

Gem::Specification.new do |s|
  s.name        = "rails-maker"
  s.version     = RailsMaker::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Konstantin Kalbazov"]
  s.email       = ["kalbazov@gmail.com"]
  s.homepage    = "http://github.com/koteus/rails-maker"
  s.summary     = "rails-maker-#{s.version}"
  s.description = "Generate a Rails app with application templates"

  #s.rubyforge_project         = "rails-maker"
  #s.required_rubygems_version = "> 1.3.6"

  # Runtime Dependencies
  s.add_dependency "activesupport"
  s.add_dependency "thor"
  s.add_dependency "rails"

  # Development Dependencies
  s.add_development_dependency "bundler"
  s.add_development_dependency "rspec"
  s.add_development_dependency "thor"

  s.has_rdoc = true
  s.extra_rdoc_files = ["README.md", "LICENSE"]

  #s.files = Dir['lib/**/*']
  #s.executables = Dir['rails-maker']

  s.bindir      = 'bin'
  s.executables = []

end

