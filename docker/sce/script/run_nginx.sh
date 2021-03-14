#!/bin/bash

# copy nginx basic config
cp /config/nginx/nginx.conf /etc/nginx/nginx.conf

# enable site
cp -r /config/nginx/sites-conf/* /etc/nginx/sites-enabled/

# Add to reboot settings
rc-update add nginx default
rc-update add php-fpm8 default

# Start php fpm
rc-service php-fpm8 restart

# Start nginx
rc-service nginx start