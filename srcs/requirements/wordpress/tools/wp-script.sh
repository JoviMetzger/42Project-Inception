#!/bin/bash

# List of required environment variables
required_vars=(
    "DOMAIN_NAME"
    "WP_DATABASE_NAME"
    "WP_DATABASE_HOST"
    "DB_ROOT_PASSWORD"
    "DB_USER"
    "WP_ADMIN"
    "WP_ADMIN_PASSWORD"
    "WP_ADMIN_EMAIL"
    "WP_USER"
    "WP_USER_PASSWORD"
    "WP_USER_EMAIL"
)

# Ensure .env variables are not empty. (Loop through the list and check if any variable is empty)
for var in "${required_vars[@]}"; do
    if [ -z "${!var}" ]; then
        echo "'${var}' is not set. Exiting."
        exit 1
    fi
done

# # Wait for the MariaDB database to be ready
# echo "Waiting for the MariaDB database to be ready..."
# until mysqladmin ping -h ${WP_DATABASE_HOST} --silent; do
#     sleep 2
# done
until mysql -h"$DB_HOST" -u"$DB_USER" -p"$DB_PASSWORD" &>/dev/null; do
    echo "Waiting for database..."
    sleep 2
done

# until mysql -h"$WP_DATABASE_HOST" -u"$DB_USER" -p"$DB_PASSWORD" &>/dev/null; do
#     echo "Waiting for database..."
#     sleep 2
# done


# Set the working directory
cd /var/www/wordpress

# Install WordPress
if [ ! -f wp-login.php ]; then 
	echo "Downloading WordPress..."
	wp core download --allow-root
fi

# Copy the wp-config.php if it doesn't already exist
if [ ! -f wp-config.php ]; then
    echo "Copying wp-config.php..."
    cp /etc/wp-config.php wp-config.php
fi

# Set up WordPress admin
echo "Setting up WordPress admin user..."
wp core install \
    --url="${DOMAIN_NAME}" \
    --title="inception" \
    --admin_user="${WP_ADMIN}" \
    --admin_password="${WP_ADMIN_PASSWORD}" \
    --admin_email="${WP_ADMIN_EMAIL}" \
    --allow-root

# Create additional WordPress user
echo "Creating WordPress user..."
wp user create "${WP_USER}" "${WP_USER_EMAIL}" \
    --user_pass="${WP_USER_PASSWORD}" \
    --allow-root

# Start PHP-FPM in the foreground
echo "Starting PHP-FPM in the foreground..."
# exec php-fpm -F
exec php7.4-fpm -F
