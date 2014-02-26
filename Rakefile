# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

Chicagofood::Application.load_tasks

esc "Grab latest db from heroku, clear local db, populate local db with Heroku db"
task :get_heroku_db do
  puts "Grabbing Heroku db..."
  system "heroku pgbackups:capture"
  puts "Downloading heroku db as latest.dump..."
  system "curl -o latest.dump `heroku pgbackups:url`"
  puts "Populating local db with latest.dump..."
  system "pg_restore --verbose --clean --no-acl --no-owner -h localhost -U chicagofood -d chicagofood_development latest.dump"
end