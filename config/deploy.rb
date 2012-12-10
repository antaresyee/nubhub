require "rvm/capistrano"

set :application, "nubhub"
set :repository,  "git@github.com:antaresyee/nubhub.git"

set :deploy_to, "/var/www/#{application}"

set :scm, :git # You can set :scm explicitly or Capistrano will make an intelligent guess based on known version control directory names
set :branch, "master"
set :deploy_via, :remote_cache
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

set :location, "ec2-107-22-68-79.compute-1.amazonaws.com"

role :web, location                         # Your HTTP server, Apache/etc
role :app, location                       # This may be the same as your `Web` server
role :db,  location, :primary => true # This is where Rails migrations will run

set :user, "root"
set :use_sudo, false
ssh_options[:forward_agent] = true
ssh_options[:keys] = [File.join(ENV["HOME"], ".ssh", "nubhub")] 
# if you want to clean up old releases on each deploy uncomment this:
# after "deploy:restart", "deploy:cleanup"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
# namespace :deploy do
#   task :start do ; end
#   task :stop do ; end
#   task :restart, :roles => :app, :except => { :no_release => true } do
#     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
#   end
# end
