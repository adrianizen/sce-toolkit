#!/bin/bash

apk update

# Install nginx
apk add nginx

# Add user
groupadd webuser && usermod -a -G webuser www-data

mkdir -p /etc/nginx/conf.d && \
mkdir -p /etc/nginx/sites-enabled && \
mkdir -p /var/log/nginx && \
touch /var/log/nginx/access.log && \
touch /var/log/nginx/error.log