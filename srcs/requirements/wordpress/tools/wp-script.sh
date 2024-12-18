#!/bin/bash

# List of required environment variables
required_vars=(
    "DOMAIN_NAME"
    "WP_DATABASE_NAME"
    "WP_DATABASE_HOST"
    "DB_ROOT_PASSWORD"
    "DB_USER"
    "DB_USER_PASSWORD"
    "WP_ADMIN"
    "WP_ADMIN_PASSWORD"
    "WP_ADMIN_EMAIL"
    "WP_USER"
    "WP_USER_PASSWORD"
    "WP_USER_EMAIL"
)

# Ensure environment variables are not empty
for var in "${required_vars[@]}"; do
    if [ -z "${!var}" ]; then
        echo "'${var}' is not set. Exiting."
        exit 1
    fi
done

# Create required directories and set permissions
mkdir -p /var/www/html/wordpress
chown -R www-data:www-data /var/www/html/wordpress

# Wait for MariaDB to be ready
echo "Waiting for MariaDB..."
sleep 2
while ! mysqladmin ping -h $WP_DATABASE_HOST --silent; do
	echo "MariaDB is not ready yet. Retrying..."
    sleep 2
done

# Set the working directory
cd /var/www/html/wordpress

# Install WordPress
if [ ! -f /var/www/html/wordpress/wp-login.php ]; then
	echo "Downloading WordPress..."
    wp --allow-root core download --path=/var/www/html/wordpress
fi

# Start PHP-FPM in the foreground
echo "Starting PHP-FPM..."
exec /usr/sbin/php-fpm8.2 -F
