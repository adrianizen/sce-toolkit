#!/bin/bash

# Install mysqli
docker-php-ext-install mysqli

# Add php
apk add php8-mysqli php8-mbstring php8-curl php8-xml php8-fpm php8-cgi \
    php8-dom php8-exif php8-fileinfo php8-json php8-openssl \
    php8-xml php8-zip php8-zlib \
    php8-ftp php8-session \
    php8-tokenizer php8-redis \
    php8-msgpack php8-readline

echo "cgi.fix_pathinfo = 0;" >> /etc/php8/php.ini

# install composer
apk add composer

# todo install imagick someday