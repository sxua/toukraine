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
