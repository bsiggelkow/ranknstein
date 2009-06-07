set :application, "ranknstein.com"
set :user, "bsiggelkow" # I used root, less problems, but not recommended.
set :use_sudo, true
set :scm, :git
 
# This distinction is necessary if the way you access github locally
# is different from the way your production environment will access it.
# For me it was the case.
set :repository, "git@github.com:bsiggelkow/ranknstein.git"
 
set :deploy_to, "/home/bsiggelkow/public_html/ranknstein" # path to app on remote machine
set :deploy_via, :remote_cache # quicker checkouts from github
 
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