#!/bin/bash

# get environment to update
if [ -z "$1" ]
	then echo "Please specify environment name"
	exit
else
	environment=$1
fi

#   function declarations
reset_git() {
    local type=$1
    if [ $type == 'reset' ]; then
        git reset --hard
    # elif [ $type == 'clean' ]; then
        #git clean -fd
    elif [ $type == 'rebase' ]; then
        git pull --rebase
    fi
}

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
PARENT_DIR=${DIR}/..
CONFIG_DIR=${PARENT_DIR}/repo-config
# CONFIG_FILE=${PARENT_DIR}/skelflo/config/update-repo.yaml
CONFIG_FILE=/opt/toolkit/config/application/update-repo.yaml
CONFIG_TEMPLATE="${DIR}/../config/application/update-repo.yaml.example"

# set the USER_GROUP
USER_GROUP=webuser

# create the config directory, if not provided yet
echo "# check the configuration"

if [ ! -f ${CONFIG_FILE} ]; then
    echo "# create new config file"
    mkdir -p ${CONFIG_DIR}
    chmod 775 -R ${CONFIG_DIR}
    cp ${CONFIG_TEMPLATE} ${CONFIG_FILE}
    sleep 1
else
    echo "# config file exist"
    sleep 1
fi

# include library function
. ${DIR}/library.sh

# read yaml file
eval $(parse_yaml $CONFIG_FILE "config_")

# get the webroot configuration
var_name=config_${environment}_webroot
eval "webroot=\$$var_name"

# get the branch configuration
var_name=config_${environment}_branch
eval "branch=\$$var_name"

# get the repo configuration
var_name=config_${environment}_repo
eval "repo=\$$var_name"


####################################
#
# start process to update the repo

echo "# processing webroot ${webroot} with branch ${branch}"
sleep 1

#   declare type of git reset
type=("reset" "rebase" "clean")

for i in "${type[@]}"
do
    echo $i
    # pull latest from repo
    cd $webroot && \
    echo "# reset current working directory" && \
    reset_git $i && \
    sleep 1 && \
    echo "# pull repo from remote source" && \
    su - kurir -c "cd ${webroot} && git pull ${repo} ${branch}:${branch}" && \
    sleep 1

    # check if repo update is success, if not then try other git reset method
    if [ $? -ne 0 ]; then
        echo "fail to update repo with git $i"
    else
        break
    fi
done



# change mod
echo "# change mod on local repo"
cd $webroot && \
chmod 777 -R ./ && chown skelflo:$USER_GROUP -R ./

if [ $? -ne 0 ]; then
   echo "fail to change mod"
   exit
fi
