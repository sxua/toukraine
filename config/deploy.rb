require 'capistrano_colors'
require 'bundler/capistrano'

set :application, "toukraine"
set :user, "toukraine"
set :group, "toukraine"
set :use_sudo, false

set :scm, :git
set :repository,  "git@github.com:sxua/#{application}.git"
set :deploy_to, "/var/www/#{application}"
set :deploy_via, :remote_cache
set :deploy_env, "production"
set :ssh_options, { forward_agent: true }

set :bundle_flags, "--deployment --quiet --binstubs --shebang ruby-local-exec"
set :default_environment, { 'PATH' => "/opt/rbenv/shims:/opt/rbenv/bin:$PATH" }

# set :shared_children, shared_children + %w(public/uploads)

set :unicorn_config, "#{current_path}/config/unicorn.rb"
set :unicorn_pid, "#{current_path}/tmp/pids/unicorn.pid"

server "dev.toukraine.org", :app, :web, :db, primary: true

after 'deploy:update_code', 'deploy:migrate'
# after 'deploy:update_code', 'deploy:symlink_uploads'
after 'deploy:restart', 'unicorn:reload'

def remote_file_exists?(full_path)
  'true' == capture("if [ -e #{full_path} ]; then echo 'true'; fi").strip
end

def remote_process_exists?(pid_file)
  capture("ps -p $(cat #{pid_file}) ; true").strip.split("\n").size == 2
end

# namespace :deploy do
#   desc 'Carrierwave files with Capistrano'
#   task :symlink_uploads do
#     run "ln -nfs #{shared_path}/uploads #{release_path}/public/uploads"
#   end
# end

namespace :unicorn do
  desc 'Reload Unicorn'
  task :reload, except: { no_release: true } do
    if remote_file_exists?(unicorn_pid)
      if remote_process_exists?(unicorn_pid)
        logger.important("Reloading...", "Unicorn")
        run "#{try_sudo} kill -USR2 `cat #{unicorn_pid}`"
      else
        logger.important("No PIDs found. Starting Unicorn server...", "Unicorn")
        if remote_file_exists?(unicorn_config)
          run "cd #{current_path} && bundle exec unicorn_rails -c #{unicorn_config} -E #{deploy_env} -D"
        else
          logger.important("Config file for Unicorn was not found at #{unicorn_config}.", "Unicorn")
        end
      end
    end
  end
  
  desc 'Start Unicorn'
  task :start, except: { no_release: true } do
    if remote_file_exists?(unicorn_pid)
      if remote_process_exists?(unicorn_pid)
        logger.important("Unicorn is already running!", "Unicorn")
        next
      else
        run "rm #{unicorn_pid}"
      end
    end
    
    if remote_file_exists?(unicorn_config)
      logger.important("Starting...", "Unicorn")
      run "cd #{current_path} && bundle exec unicorn_rails -c #{unicorn_config} -E #{deploy_env} -D"
    else
      logger.important("Config file for Unicorn was not found at #{unicorn_config}.", "Unicorn")
    end
  end
  
  desc 'Shutdown Unicorn'
  task :stop, except: { no_release: true } do
    if remote_file_exists?(unicorn_pid)
      if remote_process_exists?(unicorn_pid)
        logger.important("Stopping...", "Unicorn")
        run "#{try_sudo} kill -s QUIT `cat #{unicorn_pid}`"
      else
        run "rm #{unicorn_pid}"
        logger.important("Unicorn is not running.", "Unicorn")
      end
    else
      logger.important("No PIDs found. Check if Unicorn is running.", "Unicorn")
    end
  end
  
  desc 'Kill Unicorn'
  task :stop!, except: { no_release: true } do
    if remote_file_exists?(unicorn_pid)
      if remote_process_exists?(unicorn_pid)
        logger.important("Stopping...", "Unicorn")
        run "#{try_sudo} kill -s TERM `cat #{unicorn_pid}`"
      else
        run "rm #{unicorn_pid}"
        logger.important("Unicorn is not running.", "Unicorn")
      end
    else
      logger.important("No PIDs found. Check if Unicorn is running.", "Unicorn")
    end
  end
  
  desc 'Increase Unicorn workers by one'
  task :more, except: { no_release: true } do
    run "#{try_sudo} kill -s TTIN `cat #{unicorn_pid}`"
  end
  
  desc 'Decrease Unicorn workers by one'
  task :less, except: { no_release: true } do
    run "#{try_sudo} kill -s TTOU `cat #{unicorn_pid}`"
  end
end