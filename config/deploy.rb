require 'capistrano_colors'
require 'bundler/capistrano'

set :application, "toukraine"
set :user, "toukraine"
set :group, "toukraine"
set :use_sudo, false

task :production do
  server "beta.toukraine.org", :app, :web, :db, primary: true
  set :deploy_to, "/var/www/#{application}/production"
end

task :staging do
  server "dev.toukraine.org", :app, :web, :db, primary: true
  set :deploy_to, "/var/www/#{application}/staging"
end

set :scm, :git
set :repository,  "git@github.com:sxua/#{application}.git"
# set :deploy_to, "/var/www/#{application}"
set :deploy_via, :remote_cache
set :deploy_env, "production"
set :ssh_options, { forward_agent: true }

set :bundle_flags, "--deployment --quiet --binstubs --shebang ruby-local-exec"
set :default_environment, { 'PATH' => "/opt/rbenv/shims:/opt/rbenv/bin:$PATH" }

set :unicorn_config, "#{current_path}/config/unicorn.rb"
set :unicorn_pid, "#{current_path}/tmp/pids/unicorn.pid"

after 'deploy:update_code', 'deploy:migrate'
after 'deploy:restart', 'unicorn:reload'

def remote_file_exists?(full_path)
  'true' == capture("if [ -e #{full_path} ]; then echo 'true'; fi").strip
end

def remote_process_exists?(pid_file)
  capture("ps -p $(cat #{pid_file}) ; true").strip.split("\n").size == 2
end

namespace :deploy do
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

namespace :db do
  task :backup_name, roles: :db, only: { primary: true } do
    now = Time.now
    run "mkdir -p #{shared_path}/backups"
    backup_time = [now.year, now.month, now.day, now.hour, now.min, now.sec].join('-')
    set :backup_file, "#{shared_path}/backups/#{application}-snapshot-#{backup_time}.sql"
  end
  
  task :dump, roles: :db, only: { primary: true } do
    backup_name
    run("cat #{shared_path}/config/database.yml") { |channel, stream, data| @environment_info = YAML.load(data)[rails_env] }
    dbuser = @environment_info['username']
    dbpass = @environment_info['password']
    environment_database = @environment_info['database']
    dbhost = @environment_info['host']
    run "pg_dump -W -c -U #{dbuser} -h #{dbhost} #{environment_database} | bzip2 -c > #{backup_file}.bz2" do |channel, stream, out|
      channel.send_data "#{dbpass}\n" if out =~ /^Password:/
    end
  end
  
  task :clone_local, roles: :db, only: { primary: true } do
    backup_name
    dump
    get "#{backup_file}.bz2", "/tmp/#{application}.sql.bz2"
    development_info = YAML.load_file("config/database.yml")['development']
    run_str = "PGPASSWORD=#{development_info['password']} bzcat /tmp/#{application}.sql.bz2 | psql -U #{development_info['username']} -h #{development_info['host']} #{development_info['database']}"
    %x!#{run_str}!
  end
end

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