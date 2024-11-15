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
    -keyout "/etc/ssl/private/nginx-selfsigned.key" \
    -subj "/C=NL/ST=Holland/L=Amsterdam/O=Codam/CN=${DOMAIN_NAME}" \
    -out "/etc/ssl/certs/nginx-selfsigned.crt"

# Check if the certificate files were created successfully
if [ ! -f /etc/ssl/certs/nginx-selfsigned.crt ] || [ ! -f /etc/ssl/private/nginx-selfsigned.key ]; then
    echo "Error: SSL certificate creation failed. Exiting."
    exit 1
else
    echo "SSL certificate creation successful."
fi


# Start NGINX in the foreground
echo "Starting nginx..."
nginx -g "daemon off;"