#!/bin/bash

if [ "$EUID" -ne 0 ]
	then echo "Please run as root"
	exit
fi

usage="Usage: `basename $0` -d <database name> -u <source user> -h <source hostname> -x <target user> -t <target hostname>"

# Set up options
while getopts ":d:u:h:x:t:" options; do
 case $options in
 d ) database_name=$OPTARG;;
 u ) source_username=$OPTARG;;
 h ) source_hostname=$OPTARG;;
 x ) destination_username=$OPTARG;;
 t ) destination_hostname=$OPTARG;;
 \? ) echo -e $usage
  echo "Invalid option: -$OPTARG" >&2
  exit 1;;

 * ) echo -e $usage
  echo "Invalid option: -$OPTARG" >&2
  exit 1;;

 esac
done

read -s -p "Enter source DB ${database_name} Password: " source_password
echo ""
#echo ${source_password}

read -s -p "Enter target DB ${database_name} Password: " destination_password
echo ""
#target_password="${target_password}"

# copy the database from source to destination
mysqldbcopy \
    --source=${source_username}:"\"${source_password}\""@${source_hostname} \
    --destination=${destination_username}:"\"${destination_password}\""@${destination_hostname} \
    ${database_name}:${database_name}