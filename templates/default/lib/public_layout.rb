say '## PUBLIC LAYOUT >>'

file 'app/views/application/_flash_messages.html.haml', <<-END
- flash.each do |key, value|
  .alert{ class: "alert-" + key.to_s }
    %button{ type: "button", class: "close", "data-dismiss" => "alert"}
      &times;
    = value
END

run 'rm app/views/layouts/application.html.erb'
file 'app/views/layouts/application.html.haml', <<-END
!!! 5
%html{ lang: I18n.locale }
  %head
    %meta{ charset: 'utf-8'}
    %title #{app_name.humanize}
    = csrf_meta_tag
    = stylesheet_link_tag "application"

  %body{ "data-locale" => I18n.locale }

    .container
      =render partial: 'flash_messages'

      = yield

    = javascript_include_tag "application"
END