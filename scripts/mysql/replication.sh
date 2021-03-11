#!/bin/bash

# reference http://blog.ditullio.fr/2016/04/30/initialize-mysql-master-slave-replication-script/
# reference https://github.com/thomasvs/mysql-replication-start

master_host="localhost"

slave_host="localhost"
slave_user="root"
slave_password="root"

# database_source="database"


master_config_path="/etc/mysql/my.cnf"
master_config_backup="${master_config_path}.bak"

log_bin="/var/log/mysql/mysql-bin.log"

master_server_id=1

############################
#
# access the master database
#
############################

# check if file backup is exist
if [ ! -f ${master_config_path} ]; then
	echo "# config file ${master_config_path} not found  - exiting"
	exit 
fi

# check if file backup is exist
if [ ! -f ${master_config_backup} ]; then
	echo "# backup file ${master_config_backup} not found"
	sleep 1
else
	echo "# backup file ${master_config_backup} is found - rollback"
	mv  ${master_config_backup} ${master_config_path} 
	exit
fi

# challenge the existing username
read -p "Enter username for mysql: " master_user
read -s -p "Enter password for user ${master_user}: " master_password

read -p "Enter new username for replication: " replication_user
read -s -p "Enter new password for user ${replication_user}: " replication_password

read -p "Enter database name to replicate: " database_source

dump_file="/tmp/${database_source}-dump.sql"

# copy the configuration
echo "# create backup file ${master_config_backup}"
cp ${master_config_path} ${master_config_backup}
echo "# create backup file ${master_config_backup} - completed"
sleep 1

echo "# setup the msyqld group"

if grep -E -q "(^.*?\[mysqld\])"  ${master_config_path}
	then 
	sed -i -E "s/^.*?\[mysqld\]/\[mysqld\]/" ${master_config_path}
else
	echo "[mysqld]" >> ${master_config_path}
fi
sleep 1

# setup the server id 
echo "# setup the server id as ${master_server_id}"

if grep -E -q "(^.*?server-id\s+?=\s.+?)"  ${master_config_path}
	then 
	sed -i -E "s/(^.*?server-id\s+?=\s.+?)/server-id = ${master_server_id}/" ${master_config_path}
else
	echo "server-id = ${master_server_id}" >> ${master_config_path}
fi
sleep 1

# setup the log bin
echo "# setup the log bin ${log_bin}"

if grep -E -q "^.*?log_bin\s+?=\s.+?"  ${master_config_path}
	then 
	log_bin_esc=$(echo ${log_bin} | sed -e 's/[\/&]/\\&/g')
	sed -i -E "s/^.*?log_bin\s+?=\s.+?/log_bin = ${log_bin_esc}/" ${master_config_path}
else
	echo "log_bin = ${log_bin}" >> ${master_config_path}
fi
sleep 1

# setup the source database
echo "# setup the source database ${database_source}"

if grep -E -q "^.*?binlog_do_db\s+?=\s(.+?)"  ${master_config_path}
	then 
	sed -i -E "s/^.*?binlog_do_db\s+?=\s.+?/binlog_do_db = ${database_source}/" ${master_config_path}
else
	echo "binlog_do_db = ${database_source}" >> ${master_config_path}
fi
sleep 1

# restart the master service
echo "# restart the mysql service"
service mysql restart
sleep 1

# access the mysql shell 
echo "# create the replication user ${replication_user}"
mysql -h ${master_host} -u${master_user} -p${master_password} ${database_source} ${database_source} <<-EOSQL & 
"GRANT REPLICATION SLAVE ON *.* TO '${replication_user}'@'%' IDENTIFIED BY '${replication_password}'; 
FLUSH PRIVILEGES;
FLUSH TABLES WITH READ LOCK;
DO SLEEP(3600);
EOSQL
echo "# create the replication user ${replication_user} - completed"
sleep 1

# dump the database
echo "# taking database dump"
mysqldump -h $master_host -u${master_user} -p${master_password} --opt ${database_source} > ${dump_file}
echo "# database dump completed as ${dump_file}"
sleep 1


# get the database master log position 
echo "# get the current log file position"

master_status=$(mysql -h ${master_host} -u ${master_user} -p${master_password} ${database_source} -ANe "SHOW MASTER STATUS;" | awk '{print $1 " " $2}')
log_file=$(echo ${master_status} | cut -f1 -d ' ')
log_pos=$(echo ${master_status} | cut -f2 -d ' ')

echo "# current log file is ${log_file} and log position is ${log_pos}"
echo "${log_file}" >> /tmp/${database_source}-log_file.log
echo "${log_pos}" >> /tmp/${database_source}-log_pos.log
sleep 1

# echo "master status: ${master_status}"

echo "log file located in /tmp/${database_source}-log_file.log"
echo "log file located in /tmp/${database_source}-log_pos.log"

