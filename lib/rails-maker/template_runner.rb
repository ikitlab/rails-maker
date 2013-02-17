require 'thor'
require 'thor/actions'
require 'thor/group'

module RailsMaker

  class TemplateRunner < Thor::Group

    # Define the Standard Arguments in any base template class
    def self.extended(base)
      base.class_eval do
        argument :project, :type => :string
      end
    end

    # Includes
    include Thor::Actions

    # The method to run when the template is invoked. This is used to
    # parse custom options from the command line or complete any other
    # setup prior to invoking the system command that will construct
    # the project.
    def on_invocation
      raise RailsMaker::Errors::TemplateRunnerInvocationNotImplementedError.new("Template did not define an on_invocation method!")
    end

  end

end

