require 'spec_helper'

describe RailsMaker::CLI do

  it "should raise an error if a bad template name is passed in" do
    lambda {
      instance = RailsMaker::CLI.new
      instance.new( "app" , "default" )
    }.should raise_error
  end

end

