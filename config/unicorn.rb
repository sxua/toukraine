application = "toukraine"
app_path = "/var/www/#{application}"
bundle_path = "#{app_path}/shared/bundle"

worker_processes 2
preload_app true

listen "#{app_path}/shared/tmp/sockets/unicorn.socket", :backlog => 64

working_directory "#{app_path}/current"
stderr_path "#{app_path}/shared/log/unicorn.stderr.log"
stdout_path "#{app_path}/shared/log/unicorn.stdout.log"
pid "#{app_path}/shared/tmp/pids/unicorn.pid"

Unicorn::HttpServer::START_CTX[0] = "#{bundle_path}/bin/unicorn"
Unicorn::Configurator::DEFAULTS[:logger].formatter = Logger::Formatter.new

before_exec do |_|
  paths = (ENV["PATH"] || "").split(File::PATH_SEPARATOR)
  paths.unshift "#{bundle_path}/bin"

  ENV["PATH"] = paths.uniq.join(File::PATH_SEPARATOR)
  ENV["GEM_HOME"] = ENV['GEM_PATH'] = bundle_path
  ENV["BUNDLE_GEMFILE"] = "#{app_path}/current/Gemfile"
end

before_fork do |server, worker|
  defined?(ActiveRecord::Base) && ActiveRecord::Base.connection.disconnect!
  
  old_pid = "#{server.config[:pid]}.oldbin"
  if old_pid != server.pid
    begin
      sig = (worker.nr + 1) >= server.worker_processes ? :QUIT : :TTOU
      puts "Sending #{sig} signal to old unicorn master..."
      Process.kill(sig, File.read(old_pid).to_i)
    rescue Errno::ENOENT, Errno::ESRCH
    end
  end
  
  sleep 1
end

after_fork do |server, worker|
  defined?(ActiveRecord::Base) && ActiveRecord::Base.establish_connection
end