#!/bin/bash

# copy nginx basic config
cp /config/nginx/nginx.conf /etc/nginx/nginx.conf

# enable site
cp -r /config/nginx/sites-conf/* /etc/nginx/sites-enabled/

# Start php fpm
rc-service php-fpm8 start
rc-service php-cgi8 start

# Start nginx
rc-service nginx start