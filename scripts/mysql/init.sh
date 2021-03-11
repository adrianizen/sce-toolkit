#!/bin/bash

if [ "$EUID" -ne 0 ]
	then echo "Please run as root"
	exit
fi

echo "# Update Repository"
apt-get update -y

echo "# Install MySQL Server"
apt-get install -y mysql-server

echo "# Secure MySQL Installation"
mysql_secure_installation

echo "# Already opened connection to Slave database in idcloud"
# ufw allow 3306/tcp