#!/bin/bash

# # Create necessary directories and set permissions as root
# mkdir -p /run/mysqld /var/log/mysql
# chown -R mysql:mysql /run/mysqld /var/log/mysql

# # Start mysqld with networking enabled
# echo "Starting mysqld..."
# mysqld --skip-grant-tables --skip-networking &
# pid="$!"

# # Wait for mysqld to be ready
# echo "Waiting for mysqld to be ready..."
# while ! mysqladmin ping --silent; do
#     sleep 1
# done
# echo "MariaDB is ready."

# # Check if the database directory exists
# if [ ! -d "/var/lib/mysql/${MYSQL_DATABASE_NAME}" ]; then
#     echo "Initializing MariaDB database..."

#     # Secure MariaDB installation
#     mysql -u root <<EOF
#     -- Set the root password
#     ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';
#     FLUSH PRIVILEGES;
# EOF

# #     # Create a new database if specified
# #     if [ -n "$MYSQL_DATABASE_NAME" ]; then
# #         echo "Creating database: $MYSQL_DATABASE_NAME"
# #         mysql -u root -p"${MYSQL_ROOT_PASSWORD}" -e "CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE_NAME}\` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;"
# #     fi

# #     # Create a new user and grant privileges if specified
# #     if [ -n "$MYSQL_USER" ] && [ -n "$MYSQL_PASSWORD" ]; then
# #         echo "Creating user: $MYSQL_USER with access to $MYSQL_DATABASE_NAME"
# #         mysql -u root -p"${MYSQL_ROOT_PASSWORD}" <<EOF
# #         CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
# #         GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE_NAME}\`.* TO '${MYSQL_USER}'@'%';
# #         FLUSH PRIVILEGES;
# # EOF
# #     fi

#     echo "Database initialization complete."
# else
#     echo "Database already exists. Skipping initialization."
# fi

# # Stop the temporary mysqld instance
# echo "Stopping the temporary mysqld instance..."
# kill "$pid"
# wait "$pid"

# # Keep MariaDB running in the foreground
# echo "Starting MariaDB in the foreground..."
# exec mysqld



# # ---

# Create necessary directories and set permissions as root
mkdir -p /run/mysqld /var/log/mysql
chown -R mysql:mysql /run/mysqld /var/log/mysql

# Start mysqld with networking enabled
echo "Starting mysqld..."
mysqld --skip-networking &
pid="$!"

# Wait for mysqld to be ready
echo "Waiting for mysqld to be ready..."
while ! mysqladmin ping --silent; do
    sleep 1
done
echo "MariaDB is ready."

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

# Stop the temporary mysqld instance
echo "Stopping the temporary mysqld instance..."
kill "$pid"
wait "$pid"

# Keep MariaDB running in the foreground
echo "Starting MariaDB in the foreground..."
exec mysqld





# #!/bin/bash

# # Create necessary directories and set permissions as root
# mkdir -p /run/mysqld /var/log/mysql
# chown -R mysql:mysql /run/mysqld /var/log/mysql

# # Start mysqld without grant tables to allow initial setup
# echo "Starting mysqld with limited access for initial setup..."
# mysqld --skip-networking &
# pid="$!"

# # Wait for mysqld to be ready
# echo "Waiting for mysqld to be ready..."
# while ! mysqladmin ping --silent; do
#     sleep 1
# done
# echo "MariaDB initial setup ready."

# # Set up initial root user password and flush privileges
# mysql -u root <<EOF
# ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';
# FLUSH PRIVILEGES;
# EOF

# # Stop the temporary mysqld instance
# echo "Stopping the temporary mysqld instance after initial setup..."
# kill "$pid"
# wait "$pid"

# # Restart mysqld with full privileges
# echo "Restarting mysqld with full privileges..."
# mysqld &
# pid="$!"

# # Wait for mysqld to be ready again
# while ! mysqladmin ping --silent; do
#     sleep 1
# done
# echo "MariaDB is ready with full privileges."

# # Create a new database if specified
# if [ -n "$MYSQL_DATABASE_NAME" ]; then
#     echo "Creating database: $MYSQL_DATABASE_NAME"
#     mysql -u root -p"${MYSQL_ROOT_PASSWORD}" -e "CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE_NAME}\` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;"
# fi

# # Create a new user and grant privileges if specified
# if [ -n "$MYSQL_USER" ] && [ -n "$MYSQL_PASSWORD" ]; then
#     echo "Creating user: $MYSQL_USER with access to $MYSQL_DATABASE_NAME"
#     mysql -u root -p"${MYSQL_ROOT_PASSWORD}" <<EOF
#     CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
#     GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE_NAME}\`.* TO '${MYSQL_USER}'@'%';
#     FLUSH PRIVILEGES;
# EOF
# fi

# echo "Database initialization complete."

# # Keep MariaDB running in the foreground
# echo "Starting MariaDB in the foreground..."
# exec mysqld
