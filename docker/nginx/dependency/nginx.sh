#!/bin/bash 

apt-get install -y build-essential && \
#apt-get install -y wget && \
#wget http://nginx.org/keys/nginx_signing.key && \
#apt-key add nginx_signing.key && \
#echo "deb http://nginx.org/packages/ubuntu focal nginx" > /etc/apt/sources.list && \
#echo "deb-src http://nginx.org/packages/ubuntu focal nginx" > /etc/apt/sources.list && \
apt-get update -yqq && \
apt-get -y install nginx && \
make && \
make install && \
make modules && \
mkdir -p /etc/nginx/conf.d && \
mkdir -p /etc/nginx/sites-enabled && \
mkdir -p /var/log/nginx && \
touch /var/log/nginx/access.log && \
touch /var/log/nginx/error.log