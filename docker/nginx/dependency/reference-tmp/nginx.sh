#!/bin/bash 
apt-get install -y build-essential && \
apt-get install -y libgeoip-dev && \
wget https://nginx.org/download/nginx-1.18.0.tar.gz && \
tar zxf nginx-1.18.0.tar.gz && \
cd nginx-1.18.0 && \
./configure \
--sbin-path=/etc/nginx/sbin/nginx \
--conf-path=/etc/nginx/nginx.conf \
--pid-path=/etc/nginx/nginx.pid \
--prefix=/etc/nginx \
--with-http_ssl_module \
--with-stream \
--with-http_geoip_module \
--with-mail=dynamic \
--add-module=/usr/lib/nginx-module-vts && \
make && \
make install && \
make modules && \
mkdir -p /etc/nginx/conf.d && \
mkdir -p /etc/nginx/sites-enabled && \
mkdir -p /var/log/nginx && \
touch /var/log/nginx/access.log && \
touch /var/log/nginx/error.log