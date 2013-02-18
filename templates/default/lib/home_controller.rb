generate :controller, 'home index'
=begin
remove_file 'app/views/home/index.html.haml'
create_file 'app/views/home/index.html.haml' do
<<-FILE
%h1 #{app_name.humanize}
FILE
end
=end
route "root :to => 'home#index'"