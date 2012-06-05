set_default(:unicorn_user) { user }
set_default(:unicorn_pid) { "#{current_path}/tmp/pids/unicorn.pid" }
set_default(:unicorn_config) { "#{shared_path}/config/unicorn.#{rails_env}.rb" }
set_default(:unicorn_stderr_log) { "#{shared_path}/log/unicorn.stderr.log" }
set_default(:unicorn_stdout_log) { "#{shared_path}/log/unicorn.stdout.log" }
set_default(:unicorn_workers, 2)

namespace :unicorn do
  desc 'Setup Unicorn'
  task :setup, roles: :app do
    run "mkdir -p #{shared_path}/config"
    template "unicorn.rb.erb", unicorn_config
  end
  after "deploy:setup", "unicorn:setup"

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