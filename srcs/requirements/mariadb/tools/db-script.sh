#!/bin/bash

# # List of required environment variables
# required_vars=(
#     "DOMAIN_NAME"
#     "WP_DATABASE_NAME"
#     "WP_DATABASE_HOST"
#     "DB_ROOT_PASSWORD"
#     "DB_USER"
#     "DB_PASSWORD"
#     "WP_ADMIN"
#     "WP_ADMIN_PASSWORD"
#     "WP_ADMIN_EMAIL"
#     "WP_USER"
#     "WP_USER_PASSWORD"
#     "WP_USER_EMAIL"
# )

# # Ensure '.env' variables are not empty. (Loop through the list and check if any variable is empty)
# for var in "${required_vars[@]}"; do
#     if [ -z "${!var}" ]; then
#         echo "'${var}' is not set. Exiting."
#         exit 1
#     fi
# done

# # Create necessary directories and set permissions as root
# mkdir -p /run/mysqld 
# mkdir -p /var/log/mysql
# chown -R mysql:mysql /run/mysqld 
# chown -R mysql:mysql /var/log/mysql

# # Check if the database directory exists
# if [ ! -d "/var/lib/mysql/${WP_DATABASE_NAME}" ]; then
#     echo "Initializing WordPressDB database..."

#     # Start mysqld in the background for initialization
#     mysqld --skip-networking --socket=/run/mysqld/mysqld.sock &
#     mysql_pid=$!

#     # Wait for mysqld to be ready
#     until mysqladmin ping --socket=/run/mysqld/mysqld.sock --silent; do
#         echo "Waiting for MariaDB to be ready..."
#         sleep 5
#     done

#     # Create root user
#     echo "Initializing root user..."
#     # mysql -u root -p"${DB_ROOT_PASSWORD}" --socket=/run/mysqld/mysqld.sock <<EOF
#     mysql -u root --socket=/run/mysqld/mysqld.sock <<EOF
#     ALTER USER 'root'@'localhost' IDENTIFIED BY '${DB_ROOT_PASSWORD}';
#     FLUSH PRIVILEGES;
# EOF

#     # Create the database
#     echo "Creating database: '${WP_DATABASE_NAME}'..."
#     mysql -u root -p"${DB_ROOT_PASSWORD}" --socket=/run/mysqld/mysqld.sock <<EOF
#     CREATE DATABASE IF NOT EXISTS \`${WP_DATABASE_NAME}\` CHARACTER SET utf8 COLLATE utf8_general_ci;
# EOF

#     # Create a new user and grant privileges if specified
#     if [ -n "$DB_USER" ] && [ -n "$DB_PASSWORD" ]; then
#         echo "Creating user: '${DB_USER}' with access to '${WP_DATABASE_NAME}'"
#         mysql -u root -p"${DB_ROOT_PASSWORD}" --socket=/run/mysqld/mysqld.sock <<EOF
#         CREATE USER IF NOT EXISTS '${DB_USER}'@'%' IDENTIFIED BY '${DB_PASSWORD}';
#         GRANT ALL PRIVILEGES ON \`${WP_DATABASE_NAME}\`.* TO '${DB_USER}'@'%';
#         FLUSH PRIVILEGES;
# EOF
#     fi

#     echo "MariaDB initialization complete."

#     # Stop the background mysqld instance
#     kill "$mysql_pid"
#     wait "$mysql_pid"
# else
#     echo "MariaDB already initialized."
# fi

# # Keep MariaDB running in the foreground
# echo "Starting MariaDB..."
# exec mysqld







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
		echo "CREATE DATABASE IF NOT EXISTS \`$WP_DATABASE_NAM\`;"
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