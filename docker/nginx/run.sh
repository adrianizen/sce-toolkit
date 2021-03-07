#!/bin/bash
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
-v ${DIR}/script/:"/script/" \
--net=host \
-t $image_name \
 /bin/bash