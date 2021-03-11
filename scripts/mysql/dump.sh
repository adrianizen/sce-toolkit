#!/bin/bash

if [ "$EUID" -ne 0 ]
	then echo "Please run as root"
	exit
fi

master_host="localhost"
slave_host="localhost"

master_user="root"
master_password="root"
replication_user="slave_user"
replication_password="root"

# dump the database
echo "# taking database dump"
mysqldump -h $master_host -u${master_user} -p${master_password} --opt ${database_source} > ${dump_file}
echo "# database dump completed as ${dump_file}"
sleep 1
