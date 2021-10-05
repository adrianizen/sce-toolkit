#!/bin/bash

apk add imagemagick 

apk add --update --no-cache autoconf g++ imagemagick-dev libtool make pcre-dev \
    && pecl install imagick \
    && docker-php-ext-enable imagick \
    && apk del autoconf g++ libtool make pcre-dev

apk add libgomp

chmod +x /usr/local/lib/php/extensions/no-debug-non-zts-20200930/imagick.so
