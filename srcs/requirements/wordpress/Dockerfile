# Use Debian as a base image (Debian 12)
FROM debian:bookworm
   
# Update & intstall your package manager
RUN apt-get update -y && \
    apt-get install -y php8.2 php8.2-fpm php-mysql mariadb-client wget curl sendmail net-tools

# Install WP-CLI (wp command)
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp

# Copy script from 'tools' directory into the container’s root directory (/).
COPY ./tools/wp-script.sh /
COPY ./tools/wp-config.php /var/www/html/wordpress/wp-config.php
COPY ./tools/www.conf /etc/php/8.2/fpm/pool.d

# Make sure the script is executable (NOT necessary for 'wp-config.php', since PHP just reads it)
RUN chmod +x /wp-script.sh

# This is the port that NGINX will use to communicate with WordPress (via PHP-FPM).
EXPOSE 9000

# Start PHP-FPM and run the custom WordPress script
CMD ["/wp-script.sh"]