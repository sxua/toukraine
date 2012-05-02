require 'rbconfig'
HOST_OS = RbConfig::CONFIG['host_os']

source :rubygems

gem 'rails', '3.2.3'
gem 'pg', '~> 0.13'
gem 'activerecord-postgres-hstore'

group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'
gem 'simple_form'
gem 'carrierwave'
gem 'mini_magick'
gem 'unicorn', '~> 4.1'
gem 'capistrano'

gem "activeadmin"
gem "formtastic", "~> 2.1.1"
gem "capybara", :group => [:development, :test]
gem "therubyracer"

group :test do
  gem "cucumber-rails", :require => false
  gem "capybara"
  gem "database_cleaner"
  gem "growl"
end

guard_notifications = true
group :development do
  case HOST_OS
  when /darwin/i
    gem 'rb-fsevent'
    gem 'ruby_gntp' if guard_notifications
  when /linux/i
    gem 'libnotify'
    gem 'rb-inotify'
  when /mswin|windows/i
    gem 'rb-fchange'
    gem 'win32console'
    gem 'rb-notifu' if guard_notifications
  end
  gem "yajl-ruby"
  gem "guard-bundler"
  gem "guard-cucumber"
  gem "guard-rspec"
  gem "quiet_assets"
  gem "thin"
end

gem "rspec-rails", :group => [:development, :test]
group :assets do
  gem "twitter-bootstrap-rails"
end

gem "simple_form"