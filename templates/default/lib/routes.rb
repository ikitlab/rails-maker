run 'rm config/routes.rb'

route_components = {}

if options[:admin]
  route_components[:admin] = <<-RUBY
    namespace :admin do
      root to: 'home#index'
    end
  RUBY
end

if options[:authentication]
  route_components[:devise] = <<-RUBY
    devise_for :users, path: "auth",
      controllers: {
        omniauth_callbacks: 'users/omniauth_callbacks',
        registrations: 'users/registrations'
      },
      path_names: {
        sign_up: 'register',
        sign_in: 'login',
        sign_out: 'logout'
      }
  RUBY
end

create_file 'config/routes.rb' do
<<-RUBY
#{app_name.classify}::Application.routes.draw do

  root to: 'home#index'

  #{route_components[:devise]}

  #{route_components[:admin]}
end
RUBY
end