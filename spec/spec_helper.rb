$:.unshift(File.join(File.dirname(__FILE__), "..", "lib"))
require 'rails-maker'
RailsMaker::GEM_ROOT = File.expand_path( File.dirname( __FILE__ ) + '/../' )
