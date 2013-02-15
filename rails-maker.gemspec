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
  s.description = "Generate custom Rails app in minutes"

  s.rubyforge_project         = "rails-maker"
  s.required_rubygems_version = "> 1.3.6"

  # Runtime Dependencies
  s.add_dependency "activesupport" , "~> 3.0.7"
  s.add_dependency "rails"         , "~> 3.0.7"
  s.add_dependency "thor"          , "~> 0.14.6"

  # Development Dependencies
  s.add_development_dependency "aruba"    , "~> 0.2.3"
  s.add_development_dependency "bundler"  , "~> 1.0.12"
  s.add_development_dependency "cucumber" , "~> 0.9.3"
  s.add_development_dependency "rspec"    , "~> 2.0.0"

  s.files        = `git ls-files`.split("\n")
  s.executables  = `git ls-files`.split("\n").map{|f| f =~ /^bin\/(.*)/ ? $1 : nil}.compact
  s.require_path = "lib"
end

