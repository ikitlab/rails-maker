say '## APPLICATION LAYOUT >>'

run 'mkdir app/views/shared'

create_file 'app/views/shared/_header.html.haml' do
<<-HAML

.navbar.navbar-fixed-top
  .navbar-inner
    .container
      %a.btn.btn-navbar{ "data-target" => ".nav-collapse", "data-toggle" => "collapse" }
        %span.icon-bar
        %span.icon-bar
        %span.icon-bar
      %a#logo.brand{ href: root_path } #{app_name.humanize}
      .nav-collapse
        =render partial: 'shared/navigation_menu'
HAML
end

create_file 'app/views/shared/_flash_messages.html.haml' do
<<-FILE
- flash.each do |key, value|
  .alert{ class: "alert-" + key.to_s }
    %button{ type: "button", class: "close", "data-dismiss" => "alert"}
      &times;
    = value
FILE
end

create_file 'app/views/shared/_footer.html.haml' do
<<-FILE

FILE
end

create_file 'app/views/shared/_navigation_menu.html.haml' do
<<-FILE
%ul.nav
  = nav_link "Home", root_path
FILE
end

create_file 'app/views/shared/_end_scripts.html.haml' do
<<-FILE
  :javascript
    var _gaq = [['_setAccount', 'UA-XXXXX-X'], ['_trackPageview']];
    (function(d, t) {
      var g = d.createElement(t),
        s = d.getElementsByTagName(t)[0];
      g.async = true;
      g.src = ('https:' == location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
      s.parentNode.insertBefore(g, s);
    })(document, 'script');
FILE
end

run 'rm app/views/layouts/application.html.erb'
create_file 'app/views/layouts/application.html.haml' do
<<-HAML
!!! 5
%html{ lang: I18n.locale }
  %head
    %meta{ charset: 'utf-8'}
    %title #{app_name.humanize}
    %link{ rel: "shortcut icon", href: "/favicon.ico" }
    = csrf_meta_tag
    = stylesheet_link_tag "application"

  %body{ "data-locale" => I18n.locale }

    =render partial: 'shared/header'

    .container
      =render partial: 'shared/flash_messages'

      = yield

    = javascript_include_tag "application"
    = render partial: 'shared/analytics' if Rails.env.production?

    //= debug params if Rails.env.development?
HAML
end

run 'rm app/helpers/application_helper.rb'
create_file 'app/helpers/application_helper.rb' do
<<-RUBY
module ApplicationHelper

  def nav_link(link_text, link_path)
    class_name = current_page?(link_path) ? 'current' : ''

    content_tag(:li, :class => class_name) do
      link_to link_text, link_path
    end
  end

end
RUBY
end