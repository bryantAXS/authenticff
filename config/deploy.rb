#####################################################################################
  # The Good Lab Capistrano Deploy Script
  # Modified from Dan Benjamins version - https://github.com/dan/hivelogic-ee-deploy
#####################################################################################

if !ENV['env'].nil? then
  set(:env, ENV['env'])
else
  set(:env, 'staging')
end

set :application, ""
set :deploy_to, ""

set :user, "root"

role :app, ""
role :web, ""
role :db,  "", :primary => true

set :repository, ""
set :branch, "master"

# Additional SCM settings

default_run_options[:pty] = true  # Must be set for the password prompt from git to work
set :scm, :git
set :ssh_options, { :forward_agent => true }
set :deploy_via, :remote_cache
# set :copy_strategy, :checkout
set :keep_releases, 3
set :use_sudo, false
set :copy_compression, :bz2

# Deployment process
# before "deploy:update", "deploy:set_permissions"
after "deploy:update", "deploy:cleanup"

# Custom deployment tasks
namespace :deploy do

  desc "This is here to overide the original :restart"
  task :restart, :roles => :app do
    # do nothing but overide the default
  end

  task :finalize_update, :roles => :app do
    run "chmod -R g+w #{latest_release}" if fetch(:group_writable, true)
    # overide the rest of the default method
  end

end