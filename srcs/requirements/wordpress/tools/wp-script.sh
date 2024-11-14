#!/bin/bash

# Wait for the MariaDB database to be ready
echo "Waiting for the database to be ready..."
until mysqladmin ping -h ${MYSQL_HOST_NAME} --silent; do
    sleep 2
done

# Set the working directory
cd /var/www/wordpress

# Install WordPress
if [ ! -f wp-login.php ]; then 
	echo "Downloading WordPress..."
	wp core download \
			--path="/var/www/wordpress" \
			--allow-root
fi

# Check if wp-config.php exists, and create it if it doesn't
if [ -f /var/www/wordpress/wp-config.php ]; then
	echo "Wordpress is already exists, Skipping configuration."
else
    echo "Creating wp-config.php..."
    wp config create \
        --path="/var/www/wordpress" \
        --dbname=${MYSQL_DATABASE_NAME} \
        --dbuser=${MYSQL_USER} \
        --dbpass=${MYSQL_PASSWORD} \
        --dbhost=${MYSQL_HOST_NAME} \
        --allow-root
fi

# Set up WordPress admin
echo "Setting up WordPress admin user..."
wp core install \
    --path="/var/www/wordpress" \
    --url="${DOMAIN_NAME}" \
    --title="inception" \
    --admin_user="${WP_ADMIN}" \
    --admin_password="${WP_ADMIN_PASSWORD}" \
    --admin_email="${WP_ADMIN_EMAIL}" \
    --allow-root

# Create additional WordPress user
echo "Creating WordPress user..."
wp user create ${WP_USER} ${WP_USER_EMAIL} \
    --path="/var/www/wordpress" \
    --user_pass=${WP_USER_PASSWORD} \
    --allow-root

# Start PHP-FPM in the foreground
echo "Starting PHP-FPM in the foreground..."
exec /usr/bin/php-fpm -F
