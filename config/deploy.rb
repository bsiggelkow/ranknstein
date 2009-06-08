set :application, "ranknstein"
set :user, "bsiggelkow" # I used root, less problems, but not recommended.
set :use_sudo, false
set :scm, :git
 
# This distinction is necessary if the way you access github locally
# is different from the way your production environment will access it.
# For me it was the case.
 
set :deploy_to, "/home/bsiggelkow/public_html/#{application}.com" # path to app on remote machine
# use local copy
set :copy_strategy, :export
set :deploy_via, :copy
set :copy_cache, true
set :copy_exclude, ['.git']
set :repository, "git@github.com:bsiggelkow/#{application}.git"
 
set :domain, '209.20.64.33' # your remote machine's domain name goes here
role :app, domain
role :web, domain
 
set :runner, user
set :admin_runner, runner
 
namespace :deploy do
  task :start, :roles => [:web, :app] do
    run "cd #{deploy_to}/current && nohup thin -C production_thin.yml start"
  end
 
  task :stop, :roles => [:web, :app] do
    run "cd #{deploy_to}/current && nohup thin -C production_thin.yml stop"
  end
 
  task :restart, :roles => [:web, :app] do
    deploy.stop
    deploy.start
  end
 
  # This will make sure that Capistrano doesn't try to run rake:migrate (this is not a Rails project!)
  task :cold do
    deploy.update
    deploy.start
  end
end