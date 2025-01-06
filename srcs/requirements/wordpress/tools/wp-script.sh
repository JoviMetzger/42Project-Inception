#!/bin/bash

# Wait for MariaDB to be ready
echo "Waiting for MariaDB to connect..."
sleep 5
until mysqladmin -h${WP_DATABASE_HOST} -u${DB_USER} -p${DB_USER_PASSWORD} ping; do
    sleep 2
done

# Download WordPress if not already present
if [ ! -f /var/www/html/wordpress/index.php ]; then
    echo "Downloading and extracting WordPress..."
    curl -O https://wordpress.org/latest.tar.gz
    tar -xvf latest.tar.gz
    mv wordpress/* /var/www/html/wordpress/
    rm -rf wordpress latest.tar.gz
    echo "WordPress downloaded."

    # Set correct permissions
    echo "Setting permissions for WordPress..."
    chown -R www-data:www-data /var/www/html/wordpress
    chmod -R 755 /var/www/html/wordpress
else
    echo "WordPress is already downloaded."
fi

# Continue with WordPress configuration (if any)
if [ ! -f /var/www/html/wordpress/wp-config.php ]; then
#     echo "Creating wp-config.php file..."
#     wp core config \
#         --path=/var/www/html/wordpress \
#         --dbname=${WP_DATABASE_NAME} \
#         --dbuser=${DB_USER} \
#         --dbpass=${DB_USER_PASSWORD} \
#         --dbhost=${WP_DATABASE_HOST} \
#         --allow-root

    echo "Running WordPress installation..."
    wp core install \
        --path=/var/www/html/wordpress \
        --url=${DOMAIN_NAME} \
        --title="Inception" \
        --admin_user=${WP_ADMIN_USER} \
        --admin_password=${WP_ADMIN_PASSWORD} \
        --admin_email=${WP_ADMIN_EMAIL} \
        --allow-root
fi

echo "WordPress setup complete."

# Start PHP-FPM in the foreground
echo "Starting PHP-FPM..."
exec /usr/sbin/php-fpm8.2 

