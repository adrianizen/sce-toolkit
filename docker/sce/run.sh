#!/bin/bash


docker-compose --verbose up --build -d
# DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
# base_path="/home/skelflo"
# image_name="skelflo/sce"
# service_name="sce-service"
# container_base_name=$(echo ${image_name} |sed -E "s/[^a-zA-Z0-9_.-]/_/g")

# port=9091
# container_port=80

# docker run \
# 	--name ${container_base_name}_1 \
# 	-p $port:${container_port} \
# 	-v "${base_path}/${service_name}/sites/":"/var/www/" \
# 	-v ${DIR}/script/:"/script/" \
# 	-v ${DIR}/config/:"/config/" \
# 	-i -t $image_name \
# 	/bin/ash