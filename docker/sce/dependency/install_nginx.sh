#!/bin/bash

apk update

# Install nginx
apk add nginx

# Add user
addgroup -S webuser && adduser -S www-data -G webuser

mkdir -p /etc/nginx/conf.d && \
mkdir -p /etc/nginx/sites-enabled && \
mkdir -p /var/log/nginx && \
touch /var/log/nginx/access.log && \
touch /var/log/nginx/error.log