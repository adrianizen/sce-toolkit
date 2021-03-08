#!/bin/bash

# clear existing nginx configuration
rm -rf /etc/nginx/sites-enabled/*

# add logrotate configuration
cp -r /config/logrotate/logrotate.conf /etc/logrotate.conf && \
cp -r /config/logrotate/nginx /etc/logrotate.d/nginx && \
chmod 644 /etc/logrotate.d/nginx

# start the cron and syslog
service cron restart
service rsyslog restart


# refresh site configuration
cp -r /sites/* /etc/nginx/sites-enabled/

# test the configuration and reload the nginx
# start the nginx
if [ ! -f /bin/nginx ]; then
   ln -s /etc/nginx/sbin/nginx /bin/nginx
fi
nginx -t && nginx -s reload
