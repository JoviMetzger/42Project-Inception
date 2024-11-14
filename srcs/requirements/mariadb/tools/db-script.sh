#!/bin/bash

# Create necessary directories and set permissions as root
mkdir -p /run/mysqld /var/log/mysql
chown -R mysql:mysql /run/mysqld /var/log/mysql

# Check if the database directory exists
if [ ! -d "/var/lib/mysql/${MYSQL_DATABASE_NAME}" ]; then
    echo "Initializing MariaDB database..."

    # Start mysqld in the background for initialization
    mysqld --skip-networking --socket=/run/mysqld/mysqld.sock &
    mysql_pid=$!

    # Wait for mysqld to be ready
    until mysqladmin ping --socket=/run/mysqld/mysqld.sock --silent; do
        echo "Waiting for MariaDB to be ready..."
        sleep 2
    done

    # Secure MariaDB installation
    echo "Initializing root user..."
    mysql -u root -p"${MYSQL_ROOT_PASSWORD}" --socket=/run/mysqld/mysqld.sock <<EOF
    ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';
    FLUSH PRIVILEGES;
EOF

    # Create a new user and grant privileges if specified
    if [ -n "$MYSQL_USER" ] && [ -n "$MYSQL_PASSWORD" ]; then
        echo "Creating user: '$MYSQL_USER' with access to '$MYSQL_DATABASE_NAME'"
        mysql -u root -p"${MYSQL_ROOT_PASSWORD}" <<EOF
        CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
        GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE_NAME}\`.* TO '${MYSQL_USER}'@'%';
        FLUSH PRIVILEGES;
EOF
    fi

    echo "MariaDB initialization complete."

    # Stop the background mysqld instance
    kill "$mysql_pid"
    wait "$mysql_pid"
else
    echo "MariaDB exists already."
fi

# Keep MariaDB running in the foreground
echo "Starting MariaDB in the foreground..."
exec mysqld