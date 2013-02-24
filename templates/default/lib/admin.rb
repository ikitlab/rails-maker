say "Building admin"
generate(:controller, "admin/dashboard index")

# Do layout and SASS stuff
#apply File.expand_path("../admin/sass.rb", __FILE__)
apply File.expand_path("../admin/layout.rb", __FILE__)

create_file 'app/controllers/admin/base_controller.rb' do
<<-RUBY
class Admin::BaseController < ApplicationController

  layout 'admin'
  before_filter :verify_admin

private

  def verify_admin
    redirect_to root_url unless current_user.has_role? :admin
  end
end
RUBY
end

gsub_file 'app/controllers/admin/dashboard_controller.rb', /ApplicationController/, 'Admin::BaseController'

#apply File.expand_path("../admin/users.rb", __FILE__)
#apply File.expand_path("../admin/dashboard_spec.rb", __FILE__)
#apply File.expand_path("../admin/users_spec.rb", __FILE__)
