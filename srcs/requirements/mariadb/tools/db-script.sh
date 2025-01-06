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
# Set up the database and the user
{
	echo "FLUSH PRIVILEGES;"
	echo "CREATE DATABASE IF NOT EXISTS \`$WP_DATABASE_NAME\`;"
	echo "CREATE USER IF NOT EXISTS '$DB_USER'@'%' IDENTIFIED BY '$DB_USER_PASSWORD';"
	echo "GRANT ALL PRIVILEGES ON \`$WP_DATABASE_NAME\`.* TO '$DB_USER'@'%' IDENTIFIED BY '$DB_USER_PASSWORD';"
	echo "FLUSH PRIVILEGES;"
	echo "I am : \`$WP_DATABASE_NAME\`..."
} | mysqld --bootstrap


# # Check if MariaDB is reachable
# if mysqladmin ping -h 127.0.0.1 --silent; then
#     echo "MariaDB is running."

#     # Test database and user existence
#     echo "SHOW DATABASES;" | mysql -u root -p"${DB_ROOT_PASSWORD}"
#     echo "SHOW GRANTS FOR '${DB_USER}'@'%';" | mysql -u root -p"${DB_ROOT_PASSWORD}"
# else
#     echo "MariaDB is not running or reachable."
# fi


# Keep MariaDB running in the foreground
echo "Starting MariaDB..."
exec mysqld