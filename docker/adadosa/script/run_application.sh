#!/bin/bash

cd /var/www/html && \
    npm run prod && \
    composer update --optimize-autoloader --no-dev && \
    php artisan config:cache && \
    php artisan route:cache && \
    php artisan view:cache