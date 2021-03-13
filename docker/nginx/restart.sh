#!/bin/bash
# image_name="skelflo/nginx"
# container_base_name=$(echo ${image_name} |sed -E "s/[^a-zA-Z0-9_.-]/_/g")

# echo "# Stopping Container"
# ./kill.sh

# echo "# Running Container"
# ./run.sh

# echo "# Show Image List"
# docker ps | grep $image_name

docker-compose restart