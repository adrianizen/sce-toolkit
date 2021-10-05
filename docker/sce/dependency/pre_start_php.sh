#!/bin/bash

echo "cgi.fix_pathinfo = 0;" >> /etc/php8/php.ini

# set user and group for php-fpm8
echo "user=www-data;" >> /etc/php8/php-fpm8.d/www.conf
echo "group=webuser;" >> /etc/php8/php-fpm8.d/www.conf