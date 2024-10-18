# Use Debian as a base image (Debian 12)
FROM debian:bookworm

# Update & intstall your package manager
RUN apt-get update -y && \
	apt-get upgrade -y && \
    apt-get install -y nginx openssl -y

# Create a self-signed SSL certificate
RUN openssl req \
	-x509 \
	-nodes \
	-days 365 \ 
	-newkey rsa:2048 \
	-keyout /etc/nginx/key.pem -subj "/C=/ST=/L=/O=/CN=${DOMAIN_NAME}" \
	-out /etc/ssl/certs/nginx-selfsigned.crt \
	-subj "/CN=inception"
    # -subj "/CN=localhost"

# Copy custom Nginx configuration
COPY conf/default-nginx.conf /etc/nginx/default-nginx.conf

# Expose port 443 for HTTPS
EXPOSE 443

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]