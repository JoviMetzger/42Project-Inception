# Use Debian as a base image (Debian 12)
FROM debian:bookworm

# Set environment variables using ENV (NEED THIS: Because variables are NOT passed at Runtime)
ENV DOMAIN_NAME=${DOMAIN_NAME}
ENV WP_DATABASE_NAME=${WP_DATABASE_NAME}
ENV WP_ADMIN=${WP_ADMIN}
ENV WP_ADMIN_PASSWORD=${WP_ADMIN_PASSWORD}
ENV WP_ADMIN_EMAIL=${WP_ADMIN_EMAIL}
ENV WP_USER=${WP_USER}
ENV WP_USER_PASSWORD=${WP_USER_PASSWORD}
ENV WP_USER_EMAIL=${WP_USER_EMAIL}

# Update & intstall your package manager
RUN apt-get update -y && \
    apt-get -y install php8.2 php-fpm php-mysql mariadb-client wget curl sendmail

# Create necessary directories
RUN  mkdir -p /run/php

# Copy custom WordPress configuration from 'tools' into 'pool.d' directory.
# Copy custom WordPress script from 'tools' directory into the container’s root directory (/).
COPY /tools/www.conf /etc/php/8.2/fpm/pool.d
COPY tools/wp-script.sh /

# Set permissions for the script -> Make sure the custom script is executable
RUN chmod +x /wp-script.sh

# This is the port that NGINX will use to communicate with WordPress (via PHP-FPM).
EXPOSE 9000

# Start PHP-FPM
CMD ["/wp-script.sh"]