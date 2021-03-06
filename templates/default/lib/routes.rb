say '## ROUTES >>'

run 'rm config/routes.rb'

create_file 'config/routes.rb' do
<<-RUBY
#{ARGV[0].classify}::Application.routes.draw do

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

  namespace :admin do
    root to: 'home#index'
  end
end
RUBY
end

prepend_file 'config/routes.rb', "require 'sidekiq/web'\n"
route "mount Sidekiq::Web, at: '/sidekiq'"