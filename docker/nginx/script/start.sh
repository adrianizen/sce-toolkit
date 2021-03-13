#!/bin/bash

# overwrite the configuration
# cp -r /config/nginx.conf /etc/nginx/nginx.conf

# add logrotate configuration
cp -r /config/logrotate/logrotate.conf /etc/logrotate.conf && \
cp -r /config/logrotate/nginx /etc/logrotate.d/nginx && \
chmod 644 /etc/logrotate.d/nginx

# start the cron and syslog
service cron start
service rsyslog start

# enable trukita site
cp -r /sites/* /etc/nginx/sites-enabled/

# start the nginx
#if [ ! -f /bin/nginx ]; then
#   ln -s /etc/nginx/sbin/nginx /bin/nginx
#fi
nginx -t && \
service nginx start