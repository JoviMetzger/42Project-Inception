# Paths
COMPOSE_FILE = ./srcs/docker-compose.yml

# --- Targets ---
# Builds and starts the Docker services
all: up

# Starts the Docker services + create necessary directories
up:
	mkdir -p ${HOME}/data/mariadb
	mkdir -p ${HOME}/data/wordpress
	sudo chown -R $USER:$USER ${HOME}/data/mariadb
	sudo chown -R $USER:$USER ${HOME}/data/wordpress
	docker-compose -f $(COMPOSE_FILE) up --build -d

# Stops and removes the containers, networks
down:
	docker-compose -f $(COMPOSE_FILE) down

# Rebuild and restart of the services
re: down up

# Stops and removes the containers, networks, and any temporary resources created
clean: down
	docker system prune -af
	docker volume prune -f
	sudo rm -rf ${HOME}/data/mariadb
	sudo rm -rf ${HOME}/data/wordpress

# All Docker resources are removed, stopped and deleted
deepclean: clean
	docker stop $(docker ps -qa); docker rm $(docker ps -qa); docker rmi -f $(docker images -qa); docker volume rm $(docker volume ls -q); docker network rm $(docker network ls -q) 2>/dev/null

.PHONY: all up down re clean deepclean



docker-compose down
docker stop $(docker ps -qa); docker rm $(docker ps -qa); docker rmi -f $(docker images -qa); docker volume rm $(docker volume ls -q); docker network rm $(docker network ls -q) 2>/dev/null
sudo rm -rf ${HOME}/data/mariadb
sudo rm -rf ${HOME}/data/wordpress


mkdir -p ${HOME}/data/mariadb
mkdir -p ${HOME}/data/wordpress
sudo chown -R $USER:$USER ${HOME}/data/mariadb
sudo chown -R $USER:$USER ${HOME}/data/wordpress
docker-compose up --build -d
