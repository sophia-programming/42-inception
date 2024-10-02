#!/bin/bash

start_mariadb() {
	mariadbd &
	MARIADB_PID=$!
	sleep 5
}

stop_mariadb() {
	kill "$MARIADB_PID"
	wait "$MARIADB_PID"
}

mkdir -p /run/mysqld
adduser mysql
chown -R mysql:mysql /run/mysqld
apt-get install -y mariadb-server > /dev/null 2>&1
sed -i 's/^bind-address\s*=\s*127\.0\.0\.1/bind-address = 0.0.0.0/' /etc/mysql/mariadb.conf.d/50-server.cnf

start_mariadb
if ! mysql -uroot -e ";" ; then
	mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';"
fi

if ! mysql -uroot -p${MYSQL_ROOT_PASSWORD} -e "USE $MYSQL_DATABASE;" ; then
	mysql -uroot -p${MYSQL_ROOT_PASSWORD} -e "CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE;"
	mysql -uroot -p${MYSQL_ROOT_PASSWORD} -e "CREATE USER IF NOT EXISTS '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';"
	mysql -uroot -p${MYSQL_ROOT_PASSWORD} -e "GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%';"
	mysql -uroot -p${MYSQL_ROOT_PASSWORD} -e "FLUSH PRIVILEGES;"
fi
stop_mariadb

exec "$@"
