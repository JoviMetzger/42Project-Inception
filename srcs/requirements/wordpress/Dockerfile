# Use Debian as a base image (Debian 12)
FROM debian:bookworm
   
# Update & intstall your package manager
RUN apt-get update -y && \
    apt-get -y install php7.3 php-fpm php-mysql mariadb-client wget curl sendmail

# Copy script from 'tools' directory into the container’s root directory (/).
# `wp-config.php` needs to be copied to '/etc/wp-config.php'.
COPY ./tools/wp-script.sh /
COPY ./tools/wp-config.php /etc/wp-config.php
COPY ./tools/wp-www.conf /etc/php/7.3/fpm/pool.d

# Make sure the script is executable (NOT necessary for 'wp-config.php', since PHP just reads it)
RUN chmod +x /wp-script.sh

# This is the port that NGINX will use to communicate with WordPress (via PHP-FPM).
EXPOSE 9000

# Start PHP-FPM and run the custom WordPress script
CMD ["/wp-script.sh"]

