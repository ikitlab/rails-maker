say '## ROUTES >>'

prepend_file 'config/routes.rb', "require 'sidekiq/web'\n\n"
route "mount Sidekiq::Web, at: '/sidekiq'"