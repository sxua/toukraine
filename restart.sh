#!/bin/bash

sudo -u www-data kill -USR2 `cat /var/www/toukraine/tmp/pids/unicorn.pid`