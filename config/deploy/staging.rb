set :deploy_env, "#{stage}"
set :deploy_to, "/var/www/#{application}/#{stage}"
set :rails_env, "#{stage}"