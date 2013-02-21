run 'mkdir app/views/admin/shared'

create_file 'app/views/admin/shared/_header.html.haml' do
<<-HAML

.navbar.navbar-fixed-top
  .navbar-inner
    .container
      %a.btn.btn-navbar{ "data-target" => ".nav-collapse", "data-toggle" => "collapse" }
        %span.icon-bar
        %span.icon-bar
        %span.icon-bar
      %a.brand{ href: root_path } #{app_name.humanize}
      .nav-collapse
        =render partial: 'shared/top_navigation'
  HAML
end

create_file 'app/views/admin/shared/_flash_messages.html.haml' do
<<-HAML
- flash.each do |key, value|
  .alert{ class: "alert-" + key.to_s }
    %button{ type: "button", class: "close", "data-dismiss" => "alert"}
      &times;
    = value
  HAML
end

create_file 'app/views/admin/shared/_footer.html.haml' do
  <<-HAML
  HAML
end

create_file 'app/views/shared/_navigation_menu.html.haml' do
<<-HAML
%ul.nav
  = nav_link "Dashboard", admin_root_path
HAML
end

run 'rm app/views/layouts/admin.html.erb'
create_file 'app/views/layouts/admin.html.haml' do
<<-HAML
!!! 5
%html{ lang: I18n.locale }
  %head
    %meta{ charset: 'utf-8'}
    %title #{app_name.humanize} - AdminPanel
    %link{ rel: "shortcut icon", href: "/favicon.ico" }
    = csrf_meta_tag
    = stylesheet_link_tag "admin"

  %body{ "data-locale" => I18n.locale }

    =render partial: 'admin/shared/header'

    .container
      =render partial: 'admin/shared/flash_messages'

      = yield

    = javascript_include_tag "admin"

    //= debug params if Rails.env.development?
HAML
end
