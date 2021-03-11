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
read -s -p "Enter existing password for user ${username}: " password

hostname=localhost

echo "# generate the new password"
username_root=${database}_root
read -s -p "Enter new DB Root Password: " root_password
echo ""

username_app=${database}_app
read -s -p "Enter new DB Application User Password: " app_password
echo ""

#root_password="$( apg -n 1 -a 1 -m 16 -x 16 )"
#app_password="$( apg -n 1 -a 1 -m 16 -x 16 )"

# create the database
echo "# create the new database ${database}"
mysql -h ${hostname} -u${username} -p${password} <<-EOSQL & 
CREATE DATABASE ${database};
CREATE USER '${username_root}'@'%' IDENTIFIED BY '${root_password}';
CREATE USER '${username_app}'@'%' IDENTIFIED BY '${app_password}';
GRANT SELECT, INSERT, UPDATE, DELETE ON ${database} . * TO '${username_app}'@'%'; 
FLUSH PRIVILEGES;
GRANT ALL PRIVILEGES ON ${database} . * TO '${username_root}'@'%'; 
FLUSH PRIVILEGES;
EOSQL

if [ $? -ne 0 ]; then
    echo "# create the new database ${database} - FAIL"
    sleep 1
else
    echo ""
    echo "# create the new database ${database} - completed"
    echo "# app username ${username_app} password ${app_password}"
    echo "# root username ${username_root} password ${root_password}"
    echo ""
    sleep 1
fi


