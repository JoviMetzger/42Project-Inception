# Use Debian as a base image (Debian 12)
FROM debian:bookworm

# # Update & intstall your package manager
# RUN apt-get -y update && \
#     apt-get install -y wget php-fpm php-mysql curl mariadb-client

# Install PHP-FPM and required extensions
RUN apt-get update && apt-get install -y \
    php7.4-fpm \
    php7.4-mysql \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Download WP-CLI directly into the /usr/local/bin directory
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp

# Create the directory where WordPress will be installed
RUN mkdir -p /var/www/wordpress && chown -R www-data:www-data /var/www/wordpress

# Copy script from 'tools' directory into the container’s root directory (/).
# `wp-config.php` needs to be copied to '/etc/wp-config.php'.
COPY ./tools/wp-script.sh /
COPY ./tools/wp-config.php /etc/wp-config.php

# Make sure the script is executable (NOT necessary for 'wp-config.php', since PHP just reads it)
RUN chmod +x /wp-script.sh

# This is the port that NGINX will use to communicate with WordPress (via PHP-FPM).
EXPOSE 9000

# Start PHP-FPM and run the custom WordPress script
CMD ["/wp-script.sh"]

