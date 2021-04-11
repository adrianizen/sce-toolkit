#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# get nocache
if [ -z "$1" ]
	then
	nocache=""
else
	nocache="--no-cache "
fi

# build the docker image
docker build -t skelflo/adadosa ${DIR}/. ${nocache}