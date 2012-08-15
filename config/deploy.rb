require 'capistrano_colors'
require 'bundler/capistrano'
require 'sidekiq/capistrano'

set :default_stage, 'production'
set :stages, %w(staging production)
require 'capistrano/ext/multistage'

load 'config/recipes/base'
load 'config/recipes/unicorn'
# load 'config/recipes/db'

set :application, "toukraine"
set :user, "toukraine"
set :group, "toukraine"
set :use_sudo, false

set :sidekiq_role, :sidekiq

set :scm, :git
set :repository,  "git@github.com:sxua/#{application}.git"
set :ssh_options, { forward_agent: true }
set :deploy_via, :remote_cache

set :bundle_flags, "--deployment --quiet --binstubs --shebang ruby-local-exec"
set :default_environment, { 'PATH' => "/opt/rbenv/shims:/opt/rbenv/bin:$PATH" }

server "toukraine.org", :app, :web, :db, :sidekiq, primary: true

after 'deploy:update_code', 'deploy:migrate'
before 'deploy', 'unicorn:stop'
after 'deploy:restart', 'unicorn:start'

def remote_file_exists?(full_path)
  'true' == capture("if [ -e #{full_path} ]; then echo 'true'; fi").strip
end

def remote_process_exists?(pid_file)
  capture("ps -p $(cat #{pid_file}) ; true").strip.split("\n").size == 2
end

namespace :deploy do
  task :create_symlink do
    set :current_path, "#{deploy_to}/current"
    on_rollback do
      if previous_release
        run "rm -f #{current_path}; ln -s #{previous_release} #{current_path}; true"
      else
        logger.important "no previous release to rollback to, rollback of symlink skipped"
      end
    end
    
    run "rm -f #{current_path} && ln -s #{latest_release} #{current_path}"
  end

  namespace :assets do
    task :precompile, roles: :web, except: { no_release: true } do
      from = source.next_revision(current_revision)
      if capture("cd #{latest_release} && #{source.local.log(from)} vendor/assets/ app/assets/ | wc -l").to_i > 0
        run %Q{cd #{latest_release} && #{rake} RAILS_ENV=#{rails_env} #{asset_env} assets:precompile}
      else
        logger.info "Skipping asset pre-compilation because there were no asset changes."
      end
    end
  end
end