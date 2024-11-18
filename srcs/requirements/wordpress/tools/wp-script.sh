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
until mysqladmin -h${WP_DATABASE_HOST} -u${DB_USER} -p${DB_PASSWORD} ping; do
    echo "MariaDB is not ready yet. Retrying in 10 seconds..."
    sleep 10
done

# Install WordPress core files
if [ ! -f /var/www/html/wordpress/wp-config.php ]; then
    echo "Downloading WordPress core files..."
    wp --allow-root core download --path=/var/www/html/wordpress

    echo "Creating wp-config.php..."
    wp config create \
        --dbname="${WP_DATABASE_NAME}" \
        --dbuser="${DB_USER}" \
        --dbpass="${DB_PASSWORD}" \
        --dbhost="${WP_DATABASE_HOST}" \
        --path=/var/www/html/wordpress \
        --allow-root

    echo "Installing WordPress..."
    wp core install \
        --url="${DOMAIN_NAME}" \
        --title="inception" \
        --admin_user="${WP_ADMIN}" \
        --admin_password="${WP_ADMIN_PASSWORD}" \
        --admin_email="${WP_ADMIN_EMAIL}" \
        --path=/var/www/html/wordpress \
        --allow-root

    echo "Creating additional WordPress user..."
    wp user create "${WP_USER}" "${WP_USER_EMAIL}" \
        --user_pass="${WP_USER_PASSWORD}" \
        --path=/var/www/html/wordpress \
        --allow-root
fi

# Start PHP-FPM in the foreground
echo "Starting PHP-FPM..."
exec /usr/sbin/php-fpm8.2 -F
















# (-------------------- MY FAVOROUTE! --------------------------------)

# #!/bin/bash

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

# # Creating necessary directories
# mkdir -p /var/www/html/wordpress /run/mysqld/
# chown -R www-data:www-data /var/www/html/wordpress /run/mysqld/

# # Install WordPress
# if [ ! -f /var/www/html/wordpress/wp-config.php ]; then
   
#     # Download WP-CLI
#     curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
#     chmod +x wp-cli.phar
# 	mv /etc/wp-config.php /var/www/html/wordpress/
#     mv wp-cli.phar /usr/local/bin/wp
    
#     # Set the working directory
#     cd /var/www/html/wordpress

#     # Wait for the MariaDB database to be ready
#     wp --allow-root core download
#     echo "Connecting to MariaDB database..."
#     until mysqladmin -h${WP_DATABASE_HOST} -u${DB_USER} -p${DB_PASSWORD} ping; do
#            sleep 10
#     done

#     # Set up WordPress admin
#     echo "Setting up WordPress admin user..."
#     wp core install \
#         --url="${DOMAIN_NAME}" \
#         --title="inception" \
#         --admin_user="${WP_ADMIN}" \
#         --admin_password="${WP_ADMIN_PASSWORD}" \
#         --admin_email="${WP_ADMIN_EMAIL}" \
#         --allow-root
    
#     # Create additional WordPress user
#     echo "Creating WordPress user..."
#     wp user create "${WP_USER}" "${WP_USER_EMAIL}" \
#         --user_pass="${WP_USER_PASSWORD}" \
#         --allow-root
# fi

# # Start PHP-FPM in the foreground
# echo "Starting PHP-FPM in the foreground..."
# exec /usr/sbin/php-fpm8.2 -F
