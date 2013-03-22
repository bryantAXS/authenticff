#####################################################################################
  # The Good Lab Capistrano Deploy Script
  # Modified from Dan Benjamins version - https://github.com/dan/hivelogic-ee-deploy
#####################################################################################

set :application, "app.crowdnoize.com"
set :deploy_to, "/var/www/#{application}"
set :user, "deploy"
set :runner, "deploy"
set :use_sudo, false
default_run_options[:pty] = true
set :scm_passphrase, "RwEzpGFTx47Hyw"  # The deploy user's password

# Roles
role :app, "66.228.50.87"
role :web, "66.228.50.87"
role :db,  "66.228.50.87", :primary => true

# Additional SCM settings
set :scm, :git
set :ssh_options, { :forward_agent => true }
set :deploy_via, :remote_cache
set :copy_strategy, :checkout
set :keep_releases, 3
set :copy_compression, :bz2

set :repository, "git@github.com:bryantAXS/crowdnoize-mobile.git"
set :branch, "master"

# Deployment process
# after "deploy:update", "deploy:cleanup"

# Custom deployment tasks
namespace :deploy do

  # #{deploy_to}
  # #{shared_dir}
  # #{current_release}

  task :finalize_update, :roles => :app do


    run "mkdir #{latest_release}/vendor"
    run "cd #{latest_release} && composer install"
    run "chmod -R g+w #{latest_release}" if fetch(:group_writable, true)

  end

end