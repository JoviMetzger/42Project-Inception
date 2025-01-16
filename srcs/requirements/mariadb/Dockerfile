# Use Debian as a base image (Debian 12)
FROM debian:bookworm

# Update & intstall your package manager
RUN apt-get update -y && \
    apt-get install -y mariadb-server && \
    apt-get install -y curl

# Copy custom MariaDB configuration and script from the 'tools' directory to the container’s root directory (/)
COPY ./tools/db-script.sh /
COPY ./tools/db-config.cnf /

# Set permissions for the script -> Make sure the custom script is executable
RUN chmod +x /db-script.sh

# Make port 3306 available to the world outside this container
EXPOSE 3306

# Run the MariaDB setup script and start the server in the foreground
CMD ["/db-script.sh"]