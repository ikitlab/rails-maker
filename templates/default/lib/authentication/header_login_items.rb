
create_file 'app/views/devise/menu/_login_items.html.haml' do
  <<-'FILE'
%div.pull-right{ style: "padding-top: 9px" }
  - if current_user.present?
    = link_to current_user.username, user_path(current_user)
    &nbsp; | &nbsp;

    - if current_user.admin?
      = link_to "admin", admin_root_path
      &nbsp; | &nbsp;

    = link_to "logout", destroy_user_session_path
  - else
    = link_to "login", new_user_session_path
  FILE
end

append_file 'app/views/shared/_header.html.haml' do
  <<-'FILE'
  %ul#user_nav
    = render 'devise/menu/login_items'
  FILE
end
