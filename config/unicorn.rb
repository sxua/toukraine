worker_processes 2
working_directory "/var/www/toukraine"
preload_app true
listen "/tmp/.toukraine_socket", :backlog => 64
pid "/var/www/toukraine/tmp/pids/unicorn.pid"
stderr_path "/var/www/toukraine/log/unicorn.stderr.log"
stdout_path "/var/www/toukraine/log/unicorn.stdout.log"

before_fork do |server, worker|
  defined?(ActiveRecord::Base) && ActiveRecord::Base.connection.disconnect!
end

after_fork do |server, worker|
  defined?(ActiveRecord::Base) && ActiveRecord::Base.establish_connection
end