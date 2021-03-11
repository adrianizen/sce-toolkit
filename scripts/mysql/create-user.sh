#!/bin/bash

if [ "$EUID" -ne 0 ]
	then echo "Please run as root"
	exit
fi

usage="Usage: `basename $0` -d <database name> -u <username>"

# Set up options
while getopts ":d:u:h:" options; do
 case $options in
 d ) database=$OPTARG;;
 u ) username=$OPTARG;;
 h ) hostname=$OPTARG;;
 \? ) echo -e $usage
  exit 1;;
 * ) echo -e $usage
  exit 1;;

 esac
done

# challenge the password
read -s -p "Enter MySQL Password for user ${username}: " password

hostname=localhost

echo "# generate the new password"
username_root=${database}_root
read -s -p "Enter DB Root Password: " root_password
echo ""

username_app=${database}_app
read -s -p "Enter DB Application User Password: " app_password
echo ""

# create the database
echo "# create the new user ${database}"
mysql -h ${hostname} -u${username} -p${password} <<-EOSQL & 
CREATE USER '${username_root}'@'%' IDENTIFIED BY '${root_password}';
CREATE USER '${username_app}'@'%' IDENTIFIED BY '${app_password}';
GRANT SELECT, INSERT, UPDATE, DELETE ON ${database} . * TO '${username_app}'@'%'; 
FLUSH PRIVILEGES;
GRANT ALL PRIVILEGES ON ${database} . * TO '${username_root}'@'%'; 
FLUSH PRIVILEGES;
EOSQL

if [ $? -ne 0 ]; then
    echo "# create the new user ${username} - FAIL"
    sleep 1
else
    echo ""
    echo "# success create app username ${username_app}"
    echo "# success create root username ${username_root}"
    echo ""
    sleep 1
fi


