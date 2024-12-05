#!/bin/bash

# List of required environment variables
required_vars=(
    "DOMAIN_NAME"
    "WP_DATABASE_NAME"
    "WP_DATABASE_HOST"
    "DB_ROOT_PASSWORD"
    "DB_USER"
    "DB_PASSWORD"
    "WP_ADMIN"
    "WP_ADMIN_PASSWORD"
    "WP_ADMIN_EMAIL"
    "WP_USER"
    "WP_USER_PASSWORD"
    "WP_USER_EMAIL"
)

# Ensure '.env' variables are not empty. (Loop through the list and check if any variable is empty)
for var in "${required_vars[@]}"; do
    if [ -z "${!var}" ]; then
        echo "'${var}' is not set. Exiting."
        exit 1
    fi
done

# Move the configuration file to the correct location
mv /db-config.cnf /etc/mysql/mariadb.conf.d/db-config.cnf

# Set proper permissions
chmod 644 /etc/mysql/mariadb.conf.d/db-config.cnf

if [ ! -d /run/mysqld ]; then
    echo "Initializing MariaDB..."

	# Create necessary directories and set permissions as root
    mkdir -p /run/mysqld 
    mkdir -p /var/log/mysql
    chown -R mysql:mysql /run/mysqld 
    chown -R mysql:mysql /var/log/mysql

	# Set up the database and the user
	{
		echo "FLUSH PRIVILEGES;"
		echo "CREATE DATABASE IF NOT EXISTS \`$WP_DATABASE_NAME\`;"
		echo "CREATE USER IF NOT EXISTS '$DB_USER'@'%' IDENTIFIED BY '$DB_PASSWORD';"
		echo "GRANT ALL ON \`$WP_DATABASE_NAM\`.* TO '$DB_USER'@'%' IDENTIFIED BY '$DB_PASSWORD';"
		echo "FLUSH PRIVILEGES;"
	} | mysqld --bootstrap

    echo "MariaDB initialization complete."

else
    echo "MariaDB already initialized."
fi

# Keep MariaDB running in the foreground
echo "Starting MariaDB..."
exec mysqld