#!/bin/bash

sudo -u www-data bundle exec unicorn_rails -c /var/www/toukraine/config/unicorn.rb -E production -D