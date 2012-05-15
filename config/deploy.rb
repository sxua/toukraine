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

set :unicorn_config, "#{current_path}/config/unicorn.rb"
set :unicorn_pid, "#{current_path}/tmp/pids/unicorn.pid"

server "dev.toukraine.org", :app, :web, :db, primary: true

after 'deploy:update_code', 'deploy:migrate'
after 'deploy:restart', 'unicorn:reload'

def remote_file_exists?(full_path)
  'true' == capture("if [ -e #{full_path} ]; then echo 'true'; fi").strip
end

def remote_process_exists?(pid_file)
  capture("ps -p $(cat #{pid_file}) ; true").strip.split("\n").size == 2
end

namespace :unicorn do
  desc 'Reload Unicorn'
  task :reload, except: { no_release: true } do
    if remote_file_exists?(unicorn_pid)
      if remote_process_exists?(unicorn_pid)
        logger.important("Reloading...", "Unicorn")
        run "#{try_sudo} kill -s USR2 `cat #{unicorn_pid}`"
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

# ==============================
# Uploads
# ==============================

namespace :uploads do
  desc <<-EOD
    Creates the upload folders unless they exist
    and sets the proper upload permissions.
  EOD
  task :setup, except: { no_release: true } do
    dirs = uploads_dirs.map { |d| File.join(shared_path, d) }
    run "#{try_sudo} mkdir -p #{dirs.join(' ')} && #{try_sudo} chmod g+w #{dirs.join(' ')}"
  end

  desc <<-EOD
    [internal] Creates the symlink to uploads shared folder
    for the most recently deployed version.
  EOD
  task :symlink, except: { no_release: true } do
    run "rm -rf #{release_path}/public/uploads"
    run "ln -nfs #{shared_path}/uploads #{release_path}/public/uploads"
  end

  desc <<-EOD
    [internal] Computes uploads directory paths
    and registers them in Capistrano environment.
  EOD
  task :register_dirs do
    set :uploads_dirs, %w(uploads)
    set :shared_children, fetch(:shared_children) + fetch(:uploads_dirs)
  end

  after "deploy:finalize_update", "uploads:symlink"
  on :start, "uploads:register_dirs"
end