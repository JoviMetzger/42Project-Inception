# Use Debian as a base image (Debian 12)
FROM debian:bookworm

# Set environment variables using ENV
ENV DOMAIN_NAME=${DOMAIN_NAME}
ENV WP_DATABASE_NAME=${WP_DATABASE_NAME}
ENV WP_DATABASE_HOST=${WP_DATABASE_HOST}
ENV DB_USER=${DB_USER}
ENV DB_USER_PASSWORD=${DB_USER_PASSWORD}
ENV WP_ADMIN=${WP_ADMIN}
ENV WP_ADMIN_PASSWORD=${WP_ADMIN_PASSWORD}
ENV WP_ADMIN_EMAIL=${WP_ADMIN_EMAIL}
ENV WP_USER=${WP_USER}
ENV WP_USER_PASSWORD=${WP_USER_PASSWORD}
ENV WP_USER_EMAIL=${WP_USER_EMAIL}

# Update & intstall your package manager
RUN apt-get update -y && apt-get -y install php8.2 php-fpm php-mysql mariadb-client wget curl sendmail

# Create necessary directories
RUN  mkdir -p /run/php

# Copy script from 'tools' directory into the container’s root directory (/).
COPY /tools/www.conf /etc/php/8.2/fpm/pool.d
COPY tools/wp-script.sh wp-script.sh

# Make sure the script is executable (NOT necessary for 'wp-config.php', since PHP just reads it)
RUN chmod +x /wp-script.sh

# This is the port that NGINX will use to communicate with WordPress (via PHP-FPM).
EXPOSE 9000

# Start PHP-FPM and run the custom WordPress script
CMD ["/wp-script.sh"]