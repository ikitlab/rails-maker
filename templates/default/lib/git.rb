say '## GIT >>'

git :init

run "rm .gitignore"
file '.gitignore', <<-END
# Ignore bundler config
/.bundle

# Ignore the default SQLite database.
/db/*.sqlite3

config/database.yml

# Ignore all logfiles and tempfiles.
/log/*.log
/tmp

/public/uploads
/public/assets

# Ignore Rubymine project files
.idea/

# Ignore Ctags file
.tags

.rvmrc
.zeus.sock
.DS_Store
public/system/**/**/**/*
.sass-cache/**/*
*.swp

# Ignore sublime workspace files
*.sublime-project
*.sublime-workspace
END