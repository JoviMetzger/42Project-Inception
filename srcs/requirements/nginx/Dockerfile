# Use Debian as a base image (Debian 12)
FROM debian:bookworm

# Update & intstall your package manager
RUN apt-get update -y && \
	apt-get upgrade -y && \
    apt-get install -y nginx openssl -y

# Create a self-signed SSL certificate for TLS (or use your own cert files)
RUN openssl req \
	-x509 \
	-nodes \
	-days 365 \ 
	-newkey rsa:2048 \
	-keyout /etc/nginx/key.pem \
	-subj "/C=/ST=/L=/O=/CN=${DOMAIN_NAME}" \
	-out /etc/ssl/certs/nginx-selfsigned.crt \
	-subj "/CN=inception"

# Copy custom Nginx configuration
COPY conf/default-nginx.conf /etc/nginx/default-nginx.conf

Expose NGINX port for HTTPS
EXPOSE 443

# Start NGINX in the foreground
CMD ["nginx", "-g", "daemon off;"]
