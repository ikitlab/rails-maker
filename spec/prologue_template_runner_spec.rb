require 'spec_helper'

class TestTemplate1 < ::RailsMaker::TemplateRunner
  def on_invocation
    return "hi"
  end
end

class TestTemplate2 < ::RailsMaker::TemplateRunner
end

describe RailsMaker::TemplateRunner do

  it "should not raise an error if the on_invocation method is implemented" do
    lambda {
      TestTemplate1.new.on_invocation
    }.should_not raise_error
  end

  it "should raise an error if the on_invocation method isn't implemented" do
    lambda {
      TestTemplate2.new.on_invocation
    }.should raise_error
  end

end

