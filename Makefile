# Paths
COMPOSE_FILE = ./srcs/docker-compose.yml

# --- Targets ---
# Builds and starts the Docker services
all: up

# Starts the Docker services + create necessary directories
up:
	mkdir -p ${HOME}/data/mariadb
	mkdir -p ${HOME}/data/wordpress
	docker-compose -f $(COMPOSE_FILE) up --build -d

# Stops and removes the containers, networks, and any temporary resources created
clean:
	docker-compose -f $(COMPOSE_FILE) down
	docker system prune -af
	docker volume prune -f
	sudo rm -rf ${HOME}/data/mariadb
	sudo rm -rf ${HOME}/data/wordpress

# Rebuild and restart of the services
re:
	docker-compose -f $(COMPOSE_FILE) down
	docker-compose -f $(COMPOSE_FILE) up --build -d

# All Docker resources are removed, stopped and deleted
deepclean: clean
	docker stop $(docker ps -qa); docker rm $(docker ps -qa); docker rmi -f $(docker images -qa); docker volume rm $(docker volume ls -q); docker network rm $(docker network ls -q) 2>/dev/null

.PHONY: all up clean re deepclean

# # List of required environment variables
# required_vars=(
#     "DOMAIN_NAME"
#     "WP_DATABASE_NAME"
#     "WP_DATABASE_HOST"
#     "DB_ROOT_PASSWORD"
#     "DB_USER"
#     "DB_USER_PASSWORD"
#     "WP_ADMIN"
#     "WP_ADMIN_PASSWORD"
#     "WP_ADMIN_EMAIL"
#     "WP_USER"
#     "WP_USER_PASSWORD"
#     "WP_USER_EMAIL"
# )

# # Ensure '.env' variables are not empty. (Loop through the list and check if any variable is empty)
# for var in "${required_vars[@]}"; do
#     if [ -z "${!var}" ]; then
#         echo "'${var}' is not set. Exiting."
#         exit 1
#     fi
# done

# docker-compose down
# docker stop $(docker ps -qa); docker rm $(docker ps -qa); docker rmi -f $(docker images -qa); docker volume rm $(docker volume ls -q); docker network rm $(docker network ls -q) 2>/dev/null
# sudo rm -rf ${HOME}/data/mariadb
# sudo rm -rf ${HOME}/data/wordpress
# docker system prune -af


# mkdir -p ${HOME}/data/mariadb
# mkdir -p ${HOME}/data/wordpress
# docker-compose up --build -d


	