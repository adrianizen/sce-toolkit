#!/bin/bash

# copy nginx basic config
cp /config/nginx/nginx.conf /etc/nginx/nginx.conf

# enable site
cp -r /config/nginx/sites-conf/* /etc/nginx/sites-enabled/

# Add to reboot settings
rc-update add nginx default
rc-update add php-fpm8 default

rc-status --servicelist

# set user and group for php-fpm8
echo "user=www-data;" >> /etc/php8/php-fpm.d/www.conf
echo "group=webuser;" >> /etc/php8/php-fpm.d/www.conf

# Start php fpm
rc-service php-fpm8 start

# Start nginx
rc-service nginx start