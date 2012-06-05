set :deploy_env, 'staging'
set :deploy_to, "/var/www/#{application}/#{deploy_env}"