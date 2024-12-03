# # Use Debian as a base image (Debian 12)
# FROM debian:bookworm

# # Update & intstall your package manager
# RUN apt-get update -y && \
#     apt-get upgrade -y && \
#     apt-get install -y nginx openssl -y


# # nginx SSL
# RUN mkdir -p /etc/nginx/ssl
# RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
#     -out /etc/nginx/ssl/nginx-selfsigned.crt \
#     -keyout /etc/nginx/ssl/nginx-selfsigned.key \
#     -subj "/C=NL/ST=Holland/L=Amsterdam/O=Codam/CN=${DOMAIN_NAME}"


# # Copy custom MariaDB configuration script from the 'tools' directory to the container’s root directory
# COPY ./tools/nginx-config.conf /etc/nginx/conf.d/
# # COPY ./tools/nginx-script.sh /

# # nginx config
# RUN mkdir -p /run/nginx

# # Expose NGINX port for HTTPS
# EXPOSE 443

# # Start NGINX
# CMD ["nginx", "-g", "daemon off;"]




# Use Debian as a base image (Debian 12)
FROM debian:bookworm

# Update & intstall your package manager
RUN apt-get update -y && \
    apt-get upgrade -y && \
    apt-get install -y nginx openssl -y

# Copy custom MariaDB configuration script from the 'tools' directory to the container’s root directory
COPY ./tools/nginx-config.conf /etc/nginx/conf.d/
COPY ./tools/nginx-script.sh /

# Set permissions for the script
RUN chmod +x /nginx-script.sh

# Create necessary directories and set permissions as root
RUN mkdir -p /etc/nginx/ssl/
RUN chmod +x /etc/nginx/ssl/

# Expose NGINX port for HTTPS
EXPOSE 443

# Start NGINX in the foreground
CMD [ "/nginx-script.sh" ]
