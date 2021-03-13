#!/bin/bash 

apt-get install -y build-essential && \

apt-get update -yqq && \
apt-get -y install nginx && \
mkdir -p /etc/nginx/conf.d && \
mkdir -p /etc/nginx/sites-enabled && \
mkdir -p /var/log/nginx && \
touch /var/log/nginx/access.log && \
touch /var/log/nginx/error.log