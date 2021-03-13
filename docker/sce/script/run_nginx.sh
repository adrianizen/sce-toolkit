#!/bin/bash

# copy nginx basic config
cp /config/nginx/nginx.conf /etc/nginx/nginx.conf

# enable site
cp -r /config/nginx.sites-conf/* /etc/nginx/sites-enabled/

# start fpm
rc-service php8-fpm start

# Start nginx
rc-service nginx start