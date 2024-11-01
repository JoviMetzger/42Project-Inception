#!/bin/bash

# Create WordPress directory if it doesn’t exist
mkdir -p /var/www/html/wordpress

# Download and unpack WordPress if not already present
if [ ! -f /var/www/html/wordpress/wp-config.php ]; then
  	echo "Downloading WordPress..."
  	curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
  	chmod +x wp-cli.phar
	mv /etc/wp-config.php /var/www/html/wordpress/
	mv wp-cli.phar /usr/local/bin/wp

    # Download WordPress core
    cd /var/www/html/wordpress
    wp --allow-root core download

    # Wait for the database to be ready
    echo "Waiting for the database to be ready..."
    until mysqladmin -h${DB_HOSTNAME} -u${DB_USER} -p${DB_PASSWORD} ping; do
        sleep 2
    done

    # Set up WordPress admin
    echo "Setting up WordPress admin user..."
    wp core install \
        --url="${DOMAIN_NAME}" \
        --title="inception" \
        --admin_user="${WP_DB_ADMIN}" \
        --admin_password="${WP_DB_ADMIN_PASSWORD}" \
        --admin_email="${WP_DB_EMAIL}" \
        --allow-root

    # Create additional WordPress user
    echo "Creating WordPress user..."
	wp user create \
        ${WP_DB_USER} \
        ${WP_DB_USER_EMAIL} \
        --user_pass=${WP_DB_PASSWORD} \
        --allow-root
fi

# Start PHP-FPM in the foreground
echo "Starting PHP-FPM..."
exec /usr/sbin/php-fpm7.4 -F
