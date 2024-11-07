#!/bin/bash

# Create WordPress directory if it doesn’t exist
mkdir -p /var/www/html/wordpress

# Download and unpack WordPress if not already present
if [ ! -f /var/www/html/wordpress/wp-config.php ]; then
  	echo "Downloading WordPress..."
  	curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
  	chmod +x wp-cli.phar
	# mv /etc/wp-config.php /var/www/html/wordpress/
	mv wp-cli.phar /usr/local/bin/wp

    # Download WordPress core
    cd /var/www/html/wordpress
    wp --allow-root core download
fi

# Wait for the MariaDB database to be ready
echo "Waiting for the database to be ready..."
until mysqladmin -h mariadb -u root -p${MYSQL_ROOT_PASSWORD} ping --silent; do
    sleep 2
done

# Check if wp-config.php exists, and create it if it doesn't
if [ ! -f /var/www/html/wordpress/wp-config.php ]; then
    echo "Creating wp-config.php..."
    wp config create \
        --dbname=${MYSQL_DATABASE_NAME} \
        --dbuser=${MYSQL_USER} \
        --dbpass=${MYSQL_PASSWORD} \
        --dbhost=mariadb \
        --allow-root
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
wp user create \
    ${WP_USER} \
    ${WP_USER_EMAIL} \
    --user_pass=${WP_USER_PASSWORD} \
    --allow-root

# Start PHP-FPM in the foreground
echo "Starting PHP-FPM..."
exec /usr/sbin/php-fpm -F
