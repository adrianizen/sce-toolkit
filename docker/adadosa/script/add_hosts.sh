#!/bin/bash

#	create database dns record
host_ip=$(route -n | awk '/UG[ \t]/{print $2}')
database="$host_ip database"

#	create mail server dns record
mail_server="$host_ip mail"

#	create redis server dns record
redis="$host_ip redis"

echo $database >> /etc/hosts
echo $mail_server >> /etc/hosts
echo $redis >> /etc/hosts