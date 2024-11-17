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

# Creating necessary directories
mkdir -p /var/www/html/wordpress
touch /run/php/php7.3-fpm.pid;
chown -R www-data:www-data /var/www/*;
chown -R 755 /var/www/*;

# Install WordPress
if [ ! -f /var/www/html/wordpress/wp-config.php ]; then
   
    # Download WP-CLI directly into the /usr/local/bin directory
    curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
    chmod +x wp-cli.phar
	mv /etc/wp-config.php /var/www/html/wordpress/
    mv wp-cli.phar /usr/local/bin/wp
    
    # Set the working directory
    cd /var/www/html/wordpress

    # Wait for the MariaDB database to be ready
    wp --allow-root core download
    echo "Connecting to MariaDB database..."
    until mysqladmin -hmariadb -u${DB_USER} -p${DB_PASSWORD} ping; do
           sleep 2
    done

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
fi

# Start PHP-FPM in the foreground
echo "Starting PHP-FPM in the foreground..."
exec /usr/sbin/php-fpm7.3 -F







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

# # Wait for the MariaDB database to be ready
# echo "Waiting for the MariaDB database to be ready..."
# until mysqladmin ping -h ${WP_DATABASE_HOST} --silent; do
#     sleep 3
# done

# # Set the working directory
# cd /var/www/html

# # Install WordPress
# if [ ! -f wp-login.php ]; then 
# 	echo "Downloading WordPress..."
# 	wp core download --allow-root
# fi

# # Copy the wp-config.php if it doesn't already exist
# if [ ! -f wp-config.php ]; then
#     echo "Copying wp-config.php..."
#     cp /etc/wp-config.php wp-config.php
# fi

# # Set up WordPress admin
# echo "Setting up WordPress admin user..."
# wp core install \
#     --url="${DOMAIN_NAME}" \
#     --title="inception" \
#     --admin_user="${WP_ADMIN}" \
#     --admin_password="${WP_ADMIN_PASSWORD}" \
#     --admin_email="${WP_ADMIN_EMAIL}" \
#     --allow-root

# # Create additional WordPress user
# echo "Creating WordPress user..."
# wp user create "${WP_USER}" "${WP_USER_EMAIL}" \
#     --user_pass="${WP_USER_PASSWORD}" \
#     --allow-root

# # Start PHP-FPM in the foreground
# echo "Starting PHP-FPM in the foreground..."
# exec php-fpm -F
