#!/bin/bash

# Create necessary directories and set permissions as root
mkdir -p /run/mysqld /var/log/mysql
chown -R mysql:mysql /run/mysqld /var/log/mysql

# Check if the database directory exists
if [ ! -d "/var/lib/mysql/${MYSQL_DATABASE_NAME}" ]; then
    echo "Initializing MariaDB database..."

    # Secure MariaDB installation
    mysql -u root <<EOF
    -- Set the root password
    ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';
    FLUSH PRIVILEGES;
EOF

    # Create a new database if specified
    if [ -n "$MYSQL_DATABASE_NAME" ]; then
        echo "Creating database: $MYSQL_DATABASE_NAME"
        mysql -u root -p"${MYSQL_ROOT_PASSWORD}" -e "CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE_NAME}\` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;"
    fi

    # Create a new user and grant privileges if specified
    if [ -n "$MYSQL_USER" ] && [ -n "$MYSQL_PASSWORD" ]; then
        echo "Creating user: $MYSQL_USER with access to $MYSQL_DATABASE_NAME"
        mysql -u root -p"${MYSQL_ROOT_PASSWORD}" <<EOF
        CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
        GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE_NAME}\`.* TO '${MYSQL_USER}'@'%';
        FLUSH PRIVILEGES;
EOF
    fi

    echo "Database initialization complete."
else
    echo "Database already exists. Skipping initialization."
fi

# Keep MariaDB running in the foreground
echo "Starting MariaDB in the foreground..."
exec mysqld

# #---
# #!/bin/bash

# # Create necessary directories and set permissions
# mkdir -p /run/mysqld /var/log/mysql
# chown -R mysql:mysql /run/mysqld /var/log/mysql

# # Check if the database directory exists
# if [ ! -d "/var/lib/mysql/${MYSQL_DATABASE_NAME}" ]; then
#     echo "Initializing MariaDB database..."
    
#     # Initialize the MariaDB data directory
#     mysql_install_db --user=mysql --datadir=/var/lib/mysql
#     echo "MariaDB data directory initialized."

#     # Start MariaDB temporarily to run initialization commands
#     mysqld --skip-networking --socket=/run/mysqld/mysqld.sock &
#     pid="$!"

#     # Wait a few seconds for MariaDB to start up
#     sleep 5

#     # Secure MariaDB installation and create database/user
#     mysql -u root <<EOF
#     ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';
#     FLUSH PRIVILEGES;
# EOF

#     # Create a new database if specified
#     if [ -n "$MYSQL_DATABASE_NAME" ]; then
#         echo "Creating database: $MYSQL_DATABASE_NAME"
#         mysql -u root -p"${MYSQL_ROOT_PASSWORD}" -e "CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE_NAME}\` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;"
#     fi

#     # Create a new user and grant privileges if specified
#     if [ -n "$MYSQL_USER" ] && [ -n "$MYSQL_PASSWORD" ]; then
#         echo "Creating user: $MYSQL_USER with access to $MYSQL_DATABASE_NAME"
#         mysql -u root -p"${MYSQL_ROOT_PASSWORD}" <<EOF
#         CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
#         GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE_NAME}\`.* TO '${MYSQL_USER}'@'%';
#         FLUSH PRIVILEGES;
# EOF
#     fi

#     echo "Database initialization complete."

#     # Stop the temporary MariaDB instance
#     mysqladmin -u root -p"${MYSQL_ROOT_PASSWORD}" shutdown

# else
#     echo "Database already exists. Skipping initialization."
# fi

# # Start MariaDB in the foreground
# echo "Starting MariaDB in the foreground..."
# exec mysqld