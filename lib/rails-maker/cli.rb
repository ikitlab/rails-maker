require 'thor'
require 'thor/actions'

module RailsMaker

  class CLI < Thor

    include Thor::Actions

    desc 'new [app]', 'Create a new Rails application'
    long_desc <<-D
      The rails-maker will ask you a few questions to determine what features you
      would like to generate. Based on your answers it will setup a new Rails application.
    D

    def new(project, template_name = 'default')

      # Require the template runner
      require "#{RailsMaker::GEM_ROOT}/templates/#{template_name}/#{template_name}.rb"

      # Invoke the template runner
      # invoke "RailsMaker:Templates:#{template_name}:on_invocation"
      # invoke RailsMaker::Templates::Default.on_invocation

      # Execute the template
      exec(<<-COMMAND)
        rails new #{project} \
          --template=#{RailsMaker::GEM_ROOT}/templates/#{template_name}/bootstrap.rb \
          --skip-test-unit \
          --skip-prototype
      COMMAND

    end

    desc 'version', "Prints the rails-maker's version information"
    def version
      say "The rails-maker version #{RailsMaker::VERSION}"
    end
    map %w(-v --version) => :version

  end

end

