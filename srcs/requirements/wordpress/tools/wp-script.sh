#!/bin/bash

# Create necessary directories and set permissions
mkdir -p /var/www/html/wordpress
touch /run/php/php8.2-fpm.pid;
chown -R www-data:www-data /var/www/*;
chown -R 755 /var/www/*;

# Download/Install WordPress if not already present
if [ ! -f /var/www/html/wordpress/wp-config.php ]; then

    # Install WP-CLI (wp command)
	curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
	chmod +x wp-cli.phar
	mv /etc/wp-config.php /var/www/html/wordpress/
	mv wp-cli.phar /usr/local/bin/wp
    
    cd /var/www/html/wordpress
    
    # Downloading WordPress"
    wp --allow-root core download
    echo "WordPress downloaded."

    # Wait for MariaDB to be ready
    echo "Waiting for MariaDB to connect..."
    until mysqladmin -h${WP_DATABASE_HOST} -u${DB_USER} -p${DB_USER_PASSWORD} ping; do
           sleep 2
    done

    # Creating Wordpress Admin
	echo "Creating Wordpress Admin..."
    wp core install --url="${DOMAIN_NAME}" --title="inception" --admin_user="${WP_ADMIN}" --admin_password="${WP_ADMIN_PASSWORD}" --admin_email="${WP_ADMIN_EMAIL}" --allow-root
    
    # Creating Wordpress User"
    echo "Creating Wordpress User..." 
	wp user create ${WP_USER} ${WP_USER_EMAIL} --user_pass="${WP_USER_PASSWORD}" --allow-root

    echo "WordPress setup complete."
else
    echo "WordPress is already downloaded and setup."
fi

# Start PHP-FPM in the foreground
echo "Starting PHP-FPM..."
exec /usr/sbin/php-fpm8.2 -F