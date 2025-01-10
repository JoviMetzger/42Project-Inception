# Paths
COMPOSE_FILE = ./srcs/docker-compose.yml
ENV_FILE = ./srcs/.env

# Required environment variables
REQUIRED_ENV_VARS = DOMAIN_NAME WP_DATABASE_NAME WP_DATABASE_HOST DB_ROOT_PASSWORD DB_USER DB_USER_PASSWORD WP_ADMIN WP_ADMIN_PASSWORD WP_ADMIN_EMAIL WP_USER WP_USER_PASSWORD WP_USER_EMAIL

# Colors
RED				= \e[1;91m
RESET			= \033[0m

# --- Targets ---
# Builds and starts the Docker services
all: check-env up

# Validate the .env file
check-env:
	@if [ ! -f $(ENV_FILE) ]; then \
		echo "$(RED)Error:$(RESET) .env not found!"; \
		exit 1; \
	fi
	@for var in $(REQUIRED_ENV_VARS); do \
		if ! grep -q "^$$var=" $(ENV_FILE) || [ -z "`grep "^$$var=" $(ENV_FILE) | cut -d'=' -f2-`" ]; then \
			echo "$(RED)Error:$(RESET) Required variable '$$var' is missing or empty in .env!"; \
			exit 1; \
		fi; \
	done

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

.PHONY: all check-env up clean re deepclean
	