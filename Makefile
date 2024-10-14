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

# Cleans up Docker resources
clean: down
	docker system prune -af
	docker volume prune -f

.PHONY: all down re clean
