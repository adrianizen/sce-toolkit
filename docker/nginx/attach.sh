#!/bin/bash

image_name="skelflo/nginx"
container_base_name=$(echo ${image_name} |sed -E "s/[^a-zA-Z0-9_.-]/_/g")

echo "# attached to ${container_base_name}"

# get container id to attach
container_id=$(docker ps | grep $container_base_name | awk 'NR==1{print $1}')

docker exec -it ${container_id} /bin/bash