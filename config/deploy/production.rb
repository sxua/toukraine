set :deploy_env, 'production'
set :deploy_to, "/var/www/#{application}/#{deploy_env}"