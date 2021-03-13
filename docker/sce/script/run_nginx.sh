#!/bin/bash

# enable site
cp -r /config/sites-conf/* /etc/nginx/sites-enabled/

# Start nginx
service nginx start