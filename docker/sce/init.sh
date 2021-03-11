#!/bin/bash
current_dir=${PWD}
repo_path="/home/skelflo/sce/sites"
echo "# Repo Path ${repo_path}"

# cd $repo_path && git pull git@bitbucket.org:panjiatmojo/skelflo-docker-environment.git
eval "$(ssh-agent -s)"
ssh-add

mkdir -p ${repo_path}
cd ${repo_path} && git clone -b master git@github.com:adrianizen/sce-web.git toolkit --verbose 

# Create Database User
cd ${current_dir}
../../scripts/mysql/create.sh -d sce -u sce


# start container 
echo "# Start Container"
./run.sh