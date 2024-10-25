# Paths
COMPOSE_FILE	=	./scrs/docker-compose.yml

# --- Targets ---
# Builds and starts the Docker services
all:
	@docker-compose -f $(COMPOSE_FILE) up -d --build

# Stops and removes the containers, networks, and any temporary resources created
down:
	@docker-compose -f $(COMPOSE_FILE) down

# Rebuild and restart of the services
re: down all

# Quick cleanup without disrupting your current Docker environment
clean: down
	docker system prune -af
	docker volume prune -f

# All Docker resources are removed, stopped and deleted
fclean:
	docker stop $(docker ps -qa); docker rm $(docker ps -qa); docker rmi -f $(docker images -qa); docker volume rm $(docker volume ls -q); docker network rm $(docker network ls -q) 2>/dev/null

.PHONY: all down re clean fclean
