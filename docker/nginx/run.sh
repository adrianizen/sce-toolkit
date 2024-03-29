#!/bin/bash

# Hmm we use docker-compose.yml instead of run.sh
# docker-compose up --build -d
image_name="skelflo/nginx"
base_path="/home/skelflo"
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
service_name=nginx
container_base_name=$(echo ${image_name} |sed -E "s/[^a-zA-Z0-9_.-]/_/g")

# set container name
i=0
container_name=${container_base_name}_$[$i+1]

docker run \
--name ${container_name} \
-v "${base_path}/${service_name}/log/":"/var/log/nginx/" \
-v "${DIR}/config/sites-conf/":"/sites/" \
-v "${DIR}/config/nginx.conf":"/config/nginx.conf" \
-v "${DIR}/config/logrotate":"/config/logrotate" \
-v "${DIR}/config/certbot/conf":"/etc/letsencrypt" \
-v "${DIR}/config/certbot/www":"/var/www/certbot" \
-v "${DIR}/script/":"/script/" \
-v "/etc/ssl/":"/etc/ssl" \
--net=host \
-t $image_name \
 /bin/bash