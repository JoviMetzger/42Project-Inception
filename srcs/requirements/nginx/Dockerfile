# Use Debian as a base image (Debian 12)
FROM debian:bookworm

# Update & intstall your package manager
RUN apt-get update -y && \
    apt-get upgrade -y && \
    apt-get install -y nginx openssl -y

# Create necessary directories for SSL certificates
RUN mkdir -p /etc/nginx/ssl && \
    chmod 700 /etc/nginx/ssl

# Copy custom MariaDB configuration script from the 'tools' directory to the container’s root directory
COPY ./tools/nginx-config.conf /etc/nginx/conf.d/
COPY ./tools/nginx-script.sh /

# Set permissions for the script
RUN chmod +x /nginx-script.sh

# Expose NGINX port for HTTPS
EXPOSE 443

# Start NGINX in the foreground
CMD ["/nginx-script.sh"]
