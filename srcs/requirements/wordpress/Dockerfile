# Use Debian as a base image (Debian 12)
FROM debian:bookworm

# Update & intstall your package manager
RUN apt-get -y update && \
	apt-get install php-fpm php-mysql -y && \
	apt-get install curl -y

# Copy script from 'tools' directory into the container’s root directory (/).
COPY ./tools/wp-script.sh /
COPY ./tools/wp-config.php /

# Make sure the script is executable (NOT necessary for 'wp-config.php', since PHP just reads it)
RUN chmod +x /wp-script.sh

# This is the port that NGINX will use to communicate with WordPress (via PHP-FPM).
EXPOSE 9000

# Start PHP-FPM and run the custom WordPress script
CMD ["/wp-script.sh"]