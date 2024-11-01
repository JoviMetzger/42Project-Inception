# Paths
COMPOSE_FILE	=	./srcs/docker-compose.yml

# --- Targets ---
# Builds and starts the Docker services
all: up

# Starts the Docker services
up:
	docker-compose -f $(COMPOSE_FILE) up -d --build

# Stops and removes the containers, networks, and any temporary resources created
down:
	docker-compose -f $(COMPOSE_FILE) down

# Rebuild and restart of the services
re: down up

# Quick cleanup without disrupting your current Docker environment
clean: down
	docker system prune -af
	docker volume prune -f

# All Docker resources are removed, stopped and deleted
fclean: down
	docker stop $(shell docker ps -qa)
	docker rm $(shell docker ps -qa)
	docker rmi -f $(shell docker images -qa)
	docker volume rm $(shell docker volume ls -q)
	docker network rm $(shell docker network ls -q) 2>/dev/null

.PHONY: all up down re clean fclean
