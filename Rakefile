# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

Chicagofood::Application.load_tasks

desc "Precompiles css assets and pushes the master branch to heroku."
task :herokupublish do
  puts "Pre-compiling css assets..."
  system "bundle exec rake assets:precompile"
  puts "Pushing master branch to Heroku..."
  system "git push heroku master"
end