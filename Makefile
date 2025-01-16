# Paths
COMPOSE_FILE = ./srcs/docker-compose.yml
ENV_FILE = ./srcs/.env

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
	