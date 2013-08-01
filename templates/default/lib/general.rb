say '## GENERAL >>'

run 'rm public/index.html'
run 'rm public/images/rails.png'
run 'rm README'
run 'rm README.rdoc'
run 'rm public/favicon.ico'

file 'README.md', <<-FILE
#{ARGV[0].humanize}
===========
FILE

run 'mkdir app/workers'
run 'mkdir app/uploaders'