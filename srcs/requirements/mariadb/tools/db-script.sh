#!/bin/bash

# Move the configuration file to the correct location
mv /db-config.cnf /etc/mysql/mariadb.conf.d/db-config.cnf

# Set proper permissions
chmod 644 /etc/mysql/mariadb.conf.d/db-config.cnf

# Create necessary directories and set permissions as root
mkdir -p /run/mysqld 
mkdir -p /var/log/mysql
mkdir -p /var/lib/mysql
chown -R mysql:mysql /run/mysqld 
chown -R mysql:mysql /var/log/mysql
chown -R mysql:mysql /var/lib/mysql

echo "Initializing MariaDB..."
# Setting up the database, user, and permissions in bootstrap mode. 
# --bootstrap: Runs MariaDB in a lightweight, non-networked mode without plugins, or other unnecessary features during initialization.
{
	echo "FLUSH PRIVILEGES;"
	echo "CREATE DATABASE IF NOT EXISTS \`$WP_DATABASE_NAME\`;"
	echo "CREATE USER IF NOT EXISTS '$DB_USER'@'%' IDENTIFIED BY '$DB_USER_PASSWORD';"
	echo "GRANT ALL PRIVILEGES ON \`$WP_DATABASE_NAME\`.* TO '$DB_USER'@'%' IDENTIFIED BY '$DB_USER_PASSWORD';"
	echo "FLUSH PRIVILEGES;"
} | mysqld --bootstrap

# Keep MariaDB running in the foreground
echo "Starting MariaDB..."
exec mysqld