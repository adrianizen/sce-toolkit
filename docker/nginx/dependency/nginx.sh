#!/bin/bash 

apt-get install -y build-essential && \
apt-get install wget && \
wget http://nginx.org/keys/nginx_signing.key && \
apt-key add nginx_signing.key && \
cd /etc/apt && \
echo "deb http://nginx.org/packages/ubuntu focal nginx" > /etc/apt/sources.list && \
echo "deb-src http://nginx.org/packages/ubuntu focal nginx" > /etc/apt/sources.list && \
apt-get update && \
apt-get -y install nginx=1.18.* && \
service nginx start