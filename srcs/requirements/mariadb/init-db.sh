#!/bin/bash

# 「mariadb &」でbackgroundでコマンド実行
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
sed -i 's/^bind-address\s*=\s*127\.0\.0\.1/bind-address = 0.0.0.0/' /etc/mysql/mariadb.conf.d/50-server.cnf

start_mariadb
if ! mysql -uroot -e ";" ; then
	mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${DB_PASSWORD}';"
fi

if ! mysql -uroot -p${DB_PASSWORD} -e "USE $DB_NAME;" ; then
	mysql -u root -e "CREATE DATABASE IF NOT EXISTS $DB_NAME;"
	mysql -u root -e "CREATE USER IF NOT EXISTS '$DB_USER'@'%' IDENTIFIED BY '$DB_PASSWORD';"
	mysql -u root -e "GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$DB_USER'@'%';"
	mysql -u root -e "FLUSH PRIVILEGES;"
fi
stop_mariadb

exec "$@"
