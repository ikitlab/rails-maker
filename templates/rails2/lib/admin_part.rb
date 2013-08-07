say '## ADMIN PART >>'

# admin javascript
gsub_file 'app/assets/javascripts/application.js', /\/\/= require_tree ./, ''
file 'app/assets/javascripts/admin.js', <<-END
//= require jquery
//= require jquery_ujs
//= require jquery-ui
//= require bootstrap
END
# admin stylesheet
gsub_file 'app/assets/stylesheets/application.css', /\*= require_tree ./, ''
file 'app/assets/stylesheets/admin.css.scss', <<-END
@import "bootstrap";
END
inject_into_file 'config/application.rb', after: "class Application < Rails::Application\n" do
  "\n    config.assets.precompile += ['admin.css.scss']\n\n"
end
# admin base controller
run 'mkdir "app/controllers/admin"'
create_file 'app/controllers/admin/application_controller.rb', <<-END
class Admin::ApplicationController < ApplicationController
  layout 'admin'
  before_filter :authenticate_user!
  before_filter :verify_admin

  private

  def verify_admin
    redirect_to root_url unless current_user.admin?
  end
end
END
# admin layout with menu, flash messages
run 'mkdir app/views/admin'
run 'mkdir app/views/admin/application'

file 'app/views/admin/application/_header.html.haml', <<-END
.navbar.navbar-fixed-top
  .navbar-inner
    .container
      %a.btn.btn-navbar{ "data-target" => ".nav-collapse", "data-toggle" => "collapse" }
        %span.icon-bar
        %span.icon-bar
        %span.icon-bar
      %a.brand{ href: root_path } #{app_name.humanize}
      .nav-collapse
        =render partial: 'navigation_menu'
END

file 'app/views/admin/application/_flash_messages.html.haml', <<-END
- flash.each do |key, value|
  .alert{ class: "alert-" + key.to_s }
    %button{ type: "button", class: "close", "data-dismiss" => "alert"}
      &times;
    = value
END

file 'app/views/admin/application/_footer.html.haml'

file 'app/views/admin/application/_navigation_menu.html.haml', <<-END
%ul.nav
  %li= link_to "Dashboard", admin_root_path
END

file 'app/views/layouts/admin.html.haml', <<-END
!!! 5
%html{ lang: I18n.locale }
  %head
    %meta{ charset: 'utf-8'}
    %title #{app_name.humanize} - AdminPanel
    = csrf_meta_tag
    = stylesheet_link_tag "admin"

  %body{ "data-locale" => I18n.locale }

    =render partial: 'header'

    .container
      =render partial: 'flash_messages'

      = yield

    = javascript_include_tag "admin"
END
# admin namespace in routes
inject_into_file 'config/routes.rb', after: "mount Sidekiq::Web, at: '/sidekiq'" do
  <<-END
  \n
  namespace :admin do
    \n
  end
  END
end
# add cancan ability with admin can manage all
file 'app/models/ability.rb', <<-END
class Ability
  include CanCan::Ability

  def initialize(user)
    if user.admin?
      can :manage, :all
    end
  end
end
END