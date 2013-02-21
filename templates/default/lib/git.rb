
git :init

run 'rm .gitignore'

create_file '.gitignore' do

<<-FILE
.bundle
.DS_Store
log/*.log
tmp/**/*
config/database.yml
db/*.sqlite3
public/system/**/**/**/*
.idea/*
.sass-cache/**/*
*.swp
public/uploads
FILE

end
