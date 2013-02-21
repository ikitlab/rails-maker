run 'rm config/routes.rb'

admin = ''

if options[:admin]
  admin = <<-RUBY
    namespace :admin do
      root to: 'home#index'
    end
  RUBY
end

create_file 'config/routes.rb' do
<<-RUBY
#{app_name.classify}::Application.routes.draw do

  root to: 'home#index'

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

    #{admin}
end
RUBY
end