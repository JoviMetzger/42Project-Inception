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
    curl -s -O https://wordpress.org/latest.tar.gz > /dev/null 2>&1
    tar -xvf latest.tar.gz > /dev/null 2>&1
    mv wordpress/* /var/www/html/wordpress/ > /dev/null 2>&1
    rm -rf wordpress latest.tar.gz > /dev/null 2>&1
    echo "WordPress downloaded."

    # Set correct permissions
    echo "Setting permissions for WordPress..."
    chown -R www-data:www-data /var/www/html/wordpress
    chmod -R 755 /var/www/html/wordpress

    # Install WP-CLI (wp command)
    curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar 
    chmod +x wp-cli.phar
    mv wp-cli.phar /usr/local/bin/wp

    # Check if wp-config.php exists; if not, create it
    if [ ! -f /var/www/html/wordpress/wp-config.php ]; then
        echo "Configuring WordPress..."
        wp config create \
        --dbname=${WP_DATABASE_NAME} \
        --dbuser=${DB_USER} \
        --dbpass=${DB_USER_PASSWORD} \
        --dbhost=${WP_DATABASE_HOST} \
        --path=/var/www/html/wordpress \
        --allow-root
    else
        echo "wp-config.php already exists, skipping configuration."
    fi

    echo "Running WordPress installation..."
    wp core install \
        --path=/var/www/html/wordpress \
        --url=${DOMAIN_NAME} \
        --title="Inception" \
        --admin_user=${WP_ADMIN_USER} \
        --admin_password=${WP_ADMIN_PASSWORD} \
        --admin_email=${WP_ADMIN_EMAIL} \
        --allow-root

    echo "WordPress setup complete."
else
    echo "WordPress is already downloaded and setup."
fi

# Start PHP-FPM in the foreground
echo "Starting PHP-FPM..."
exec /usr/sbin/php-fpm8.2 
