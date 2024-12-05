#!/bin/bash

# Ensure ${DOMAIN_NAME} is not empty.
if [ -z "${DOMAIN_NAME}" ]; then
    echo "DOMAIN_NAME is not set. Exiting."
    exit 1
fi

# Create a self-signed SSL certificate for TLS (or use your own cert files)
echo "Creating a self-signed SSL certificate..."
openssl req \
    -x509 \
    -nodes \
    -days 365 \
    -newkey rsa:2048 \
    -subj "/C=NL/ST=Holland/L=Amsterdam/O=Codam/CN=${DOMAIN_NAME}" \
    -out "/etc/ssl/selfsigned.crt" \
    -keyout "/etc/ssl/selfsigned.key"

# # Replace $DOMAIN_NAME in the Nginx configuration template
# echo "Configuring Nginx..."
# envsubst '${DOMAIN_NAME}' < /etc/nginx/conf.d/nginx-config.conf.template > /etc/nginx/conf.d/nginx-config.conf

# Start NGINX in the foreground
echo "Starting nginx..."
nginx -g "daemon off;"
