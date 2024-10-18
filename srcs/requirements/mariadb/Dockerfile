# Use Debian as a base image (Debian 12)
FROM debian:bookworm

# Update & intstall your package manager
RUN apt-get update -y && \
    apt-get install -y mariadb-server

# Copy custom MariaDB configuration if needed
COPY my.cnf /etc/mysql/my.cnf

# Make port 3306 available to the world outside this container
EXPOSE 3306

# Define the command to run the app
CMD ["mysqld"]