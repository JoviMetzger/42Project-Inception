# Paths
COMPOSE_FILE	=	./scrs/docker-compose.yml
DOCKER_PATH=/usr/bin/docker-compose

# Compiler and flags

# Targets
# Builds and starts the Docker services
all:
	@docker-compose -f $(COMPOSE_FILE) up -d --build

# Stops and removes the containers, networks, and any temporary resources created
down:
	@docker-compose -f $(COMPOSE_FILE) down

# Rebuild and restart of the services
re: down all

# Aggressively cleans up Docker resources
clean:
	@docker stop $$(docker ps -qa);\
	docker rm $$(docker ps -qa);\
	docker rmi -f $$(docker images -qa);\
	docker volume rm $$(docker volume ls -q);\
	docker network rm $$(docker network ls -q);\

.PHONY: all re down clean
