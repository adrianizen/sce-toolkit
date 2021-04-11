#!/bin/bash
current_dir=${PWD}
repo_path="/home/skelflo/adadosa/sites"
echo "# Repo Path ${repo_path}"

# cd $repo_path && git pull git@bitbucket.org:panjiatmojo/skelflo-docker-environment.git
eval "$(ssh-agent -s)"
ssh-add

cd ${repo_path}"/adadosa" && git pull git@github.com:adrianizen/adadosa-web.git 
sleep 1
# change mod
echo "# change mod on local repo"
chmod 777 -R ./ && chown www-data:webuser -R ./

if [ $? -ne 0 ]; then
   echo "fail to change mod"
   exit
fi