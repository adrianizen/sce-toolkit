#!/bin/bash
current_dir=${PWD}
repo_path="/home/skelflo/adadosa/sites"
echo "# Repo Path ${repo_path}"

eval "$(ssh-agent -s)"
ssh-add

mkdir -p ${repo_path}
cd ${repo_path} && git clone -b master git@github.com:adrianizen/adadosa-web.git adadosa --verbose 
# change mod
echo "# change mod on local repo"
chmod 777 -R ./ && chown www-data:webuser -R ./

if [ $? -ne 0 ]; then
   echo "fail to change mod"
   exit
fi


# Create Database User
# cd ${current_dir}
# ../../scripts/mysql/create.sh -d sce -u root


# start container 
echo "# Start Container"
./run.sh