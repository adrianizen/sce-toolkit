#!/bin/bash

# set the image name
image_name="skelflo/nginx"

# get the container base name
container_base_name=$(echo ${image_name} |sed -E "s/[^a-zA-Z0-9_.-]/_/g")

# stop container with matched base name
docker stop $(docker ps | grep "${container_base_name}" | awk '{print $1}') 

# remove unused container with matched base name
docker rm -f $(docker ps -a | grep "${container_base_name}" | awk '{print $1}')