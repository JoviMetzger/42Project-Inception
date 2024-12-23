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
touch /run/php/php8.2-fpm.pid;
chown -R www-data:www-data /var/www/*;
chown -R 755 /var/www/*;

# Wait for MariaDB to be ready
echo "Waiting for MariaDB to connect..."
until mysqladmin -h${WP_DATABASE_HOST} -u${DB_USER} -p${DB_USER_PASSWORD} ping; do
        sleep 2
done

# Install WordPress
# Set the working directory
cd /var/www/html/wordpress
# if [ ! -f /var/www/html/wordpress/wp-login.php ]; then
	echo "Downloading WordPress..."
    wp --allow-root core download --path=/var/www/html/wordpress
# fi


echo "Initializing Wordpress..."
if [ ! -f /var/www/html/wordpress/wp-config.php ]; then

    # Creating Admin
	echo "Creating wordpress Admin"
    wp core install \
        --url="${DOMAIN_NAME}" \
        --title="inception" \
        --admin_user="${WP_ADMIN}" \
        --admin_password="${WP_ADMIN_PASSWORD}" \
        --admin_email="${WP_ADMIN_EMAIL}" \
        --allow-root

    # Creating User
    echo "Creating wordpress User" 
	wp user create ${WP_USER} ${WP_USER_EMAIL} \
        --user_pass=${WP_USER_PASSWORD} \
        --allow-root
fi
echo "Wordpress initialization complete."

# Start PHP-FPM in the foreground
echo "Starting PHP-FPM..."
exec /usr/sbin/php-fpm8.2 -F
