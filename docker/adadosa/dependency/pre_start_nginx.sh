#!/bin/bash

apk update

# Install nginx
apk add nginx

# Add webuser group and set www-data to webuser group 
addgroup -S webuser && addgroup www-data webuser

mkdir -p /etc/nginx/conf.d && \
mkdir -p /etc/nginx/sites-enabled && \
mkdir -p /var/log/nginx && \
touch /var/log/nginx/access.log && \
touch /var/log/nginx/error.log

