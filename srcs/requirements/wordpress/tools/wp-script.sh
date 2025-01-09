#!/bin/bash

echo "WORDPRESS"
echo "DB_HOST: ${WP_DATABASE_HOST}, DB_USER: ${DB_USER}, DB_PASSWORD: ${DB_USER_PASSWORD}"



# # Wait for MariaDB to be ready
# echo "Waiting for MariaDB to connect..."
# sleep 5
# until mysqladmin -h${WP_DATABASE_HOST} -u${DB_USER} -p${DB_USER_PASSWORD} ping; do
#     sleep 2
# done


# # Try connecting as root
# echo "Updating database user privileges..."
# if mysql -h${WP_DATABASE_HOST} -uroot -p${DB_ROOT_PASSWORD} -e "SELECT 1;" &> /dev/null; then
#     echo "Connected as root."
#     mysql -h${WP_DATABASE_HOST} -uroot -p${DB_ROOT_PASSWORD} <<EOF
#     ALTER USER '${DB_USER}'@'%' IDENTIFIED BY '${DB_USER_PASSWORD}';
#     GRANT ALL PRIVILEGES ON ${WP_DATABASE_NAME}.* TO '${DB_USER}'@'%' IDENTIFIED BY '${DB_USER_PASSWORD}';
#     FLUSH PRIVILEGES;
# EOF
# elif mysql -h${WP_DATABASE_HOST} -uadmin -p${ADMIN_PASSWORD} -e "SELECT 1;" &> /dev/null; then
#     echo "Connected as admin."
#     mysql -h${WP_DATABASE_HOST} -uadmin -p${ADMIN_PASSWORD} <<EOF
#     ALTER USER '${DB_USER}'@'%' IDENTIFIED BY '${DB_USER_PASSWORD}';
#     GRANT ALL PRIVILEGES ON ${WP_DATABASE_NAME}.* TO '${DB_USER}'@'%' IDENTIFIED BY '${DB_USER_PASSWORD}';
#     FLUSH PRIVILEGES;
# EOF
# else
#     echo "Failed to connect to MariaDB as root or admin. Check credentials."
#     exit 1
# fi

# echo "Database user privileges updated."


# # Download WordPress if not already present
# if [ ! -f /var/www/html/wordpress/index.php ]; then
#     echo "Downloading and extracting WordPress..."
#     curl -s -O https://wordpress.org/latest.tar.gz > /dev/null 2>&1
#     tar -xvf latest.tar.gz > /dev/null 2>&1
#     mv wordpress/* /var/www/html/wordpress/ > /dev/null 2>&1
#     rm -rf wordpress latest.tar.gz > /dev/null 2>&1
#     echo "WordPress downloaded."

#     # Set correct permissions
#     echo "Setting permissions for WordPress..."
#     chown -R www-data:www-data /var/www/html/wordpress
#     chmod -R 755 /var/www/html/wordpress

#     # Configure wp-config.php
#     echo "Configuring WordPress..."
#     wp config create \
#     --dbname=${WP_DATABASE_NAME} \
#     --dbuser=${DB_USER} \
#     --dbpass=${DB_USER_PASSWORD} \
#     --dbhost=${WP_DATABASE_HOST} \
#     --path=/var/www/html/wordpress \
#     --allow-root

#     echo "Running WordPress installation..."
#     wp core install \
#         --path=/var/www/html/wordpress \
#         --url=${DOMAIN_NAME} \
#         --title="Inception" \
#         --admin_user=${WP_ADMIN_USER} \
#         --admin_password=${WP_ADMIN_PASSWORD} \
#         --admin_email=${WP_ADMIN_EMAIL} \
#         --allow-root

#     echo "WordPress setup complete."
# else
#     echo "WordPress is already downloaded and setup."
# fi

# # Start PHP-FPM in the foreground
# echo "Starting PHP-FPM..."
# exec /usr/sbin/php-fpm8.2 


# # # Install WP-CLI (wp command)
# RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
#     && chmod +x wp-cli.phar \
#     && mv wp-cli.phar /usr/local/bin/wp

# --- Testing this later ---
echo starting..........................333333333333................
mkdir -p /var/www/html/wordpress
touch /run/php/php7.3-fpm.pid;
chown -R www-data:www-data /var/www/*;
chown -R 755 /var/www/*;
if [ ! -f /var/www/html/wordpress/wp-config.php ]; then
	curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
	chmod +x wp-cli.phar
	mv /etc/wp-config.php /var/www/html/wordpress/
	mv wp-cli.phar /usr/local/bin/wp
    cd /var/www/html/wordpress
    wp --allow-root core download
    echo "trying to connect with the database"
    until mysqladmin -hmariadb -u${MYSQL_USER} -p${MYSQL_PASSWORD} ping; do
           sleep 2
    done
	echo "creating admin user"
    #wp config create --allow-root --dbname=${MYSQL_DATABASE} --dbuser=${MYSQL_USER} --dbhost=mariadb --dbpass=${MYSQL_PASSWORD} --config-file=/var/www/html/wordpress/wp-config.php
    wp core install --url="${DOMAIN_NAME}" --title="inception" --admin_user="${WP_DB_ADMIN}" --admin_password="${WP_DB_ADMIN_PASSWORD}" --admin_email="${WP_DB_EMAIL}" --allow-root
    echo "creating wordpress user......" 
	wp user create ${WP_DB_USER} ${WP_DB_USER_EMAIL} --user_pass=${WP_DB_PASSWORD} --allow-root
fi
echo "doneeeeeeeeeeeeeeeeeee..................."
exec /usr/sbin/php-fpm8.2 