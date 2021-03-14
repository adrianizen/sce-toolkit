#!/bin/bash
current_dir=${PWD}
repo_path="/home/skelflo/sce/sites"
echo "# Repo Path ${repo_path}"

# cd $repo_path && git pull git@bitbucket.org:panjiatmojo/skelflo-docker-environment.git
eval "$(ssh-agent -s)"
ssh-add

mkdir -p ${repo_path}
cd ${repo_path} && git pull -b master git@github.com:adrianizen/sce-web.git sce --verbose 
sleep 1
# change mod
echo "# change mod on local repo"
chmod 777 -R ./ && chown www-data:webuser -R ./

if [ $? -ne 0 ]; then
   echo "fail to change mod"
   exit
fi