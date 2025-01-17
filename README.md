# 🥊 Inception 🥊

This project is designed to broaden your understanding of system administration by using Docker. <br>
You will virtualize several Docker images, creating them in your new personal virtual machine. <br><br>

## Step By Step
1) [Read About *(make sure you understand)*:](#Read-About)
    - [What is Docker?](#1️⃣What-is-Docker)
    - [What is Docker Compose?](#2️⃣What-is-Docker-Compose)
    - [What are Multi-container Applications?](#3️⃣What-are-Multi-container-Applications)
    - [What is a Docker Image?](#4️⃣What-is-a-Docker-Image)
    - [What Are Volumes?](#5️⃣What-Are-Volumes)
    - [Virtual Machine vs Docker](#6️⃣Virtual-Machine-vs-Docker)
2) [Set up your Virtual Machine:](#7️⃣Set-up-your-Virtual-Machine)
    - [How to set up your Virtual Machine](#1️⃣how-to-set-up-your-Virtual-Machine)
    - [Create a Shared Folder *(between your VM and host)*](#2️⃣Create-a-Shared-Folder)
    - [Connect to your host terminal *(because VM terminal sucks)*](#3️⃣Connect-to-your-host-terminal)
3) [Set Up:](#Set-up)
    - [Extra *(getting started)*](#extra)
    - [MariaDB](#mariadb)
    - [WordPress](#wordpress)
    - [Nginx](#nginx)
4) [Installation:](#Installation)
5) [Resources:](#Resources)

<br>

---

## 🫖Read About 

### 1️⃣What is Docker?
Docker is a platform that helps developers easily create, deploy, and run applications in containers. <br>
Containers are lightweight, portable environments that package everything needed to run a piece of software—code, <br>
libraries, dependencies, and configuration—so it can run reliably on any system, regardless of the environment. <br><br>

**Key Concepts in Docker:**
1) **Containers:** <br>
- A container is like a small, lightweight virtual machine that runs an application and its dependencies on any system.<br>
- It ensures that the application works the same in different environments *(your laptop, the cloud, or on a server)*.<br>
- Unlike full virtual machines, containers share the host system’s OS kernel, <br>
 making them faster and more efficient in terms of resource usage.
2) **Images:** <br>
- A Docker image is like a template or blueprint for creating containers. <br>
 It contains everything needed to run an app, including the code, libraries, environment variables, and system tools.<br>
- Images are read-only, and when a container starts from an image, <br>
 it adds a writable layer on top of the image where it can make changes.<br>
3) **Docker Daemon:** <br>
- The Docker daemon is the background service that runs on your host machine and is responsible <br>
 for managing Docker containers, images, volumes, an networks.
- It listens for Docker commands and executes them *(like pulling images, starting containers, or creating networks)*.<br>
4) **Dockerfile:** <br>
- A Dockerfile is a text file that contains a set of instructions for building a Docker image.<br>
- Think of it as a recipe: it specifies the base image *(Debian)*, the app’s code, dependencies, and how to run the app.<br>
5) **Docker Hub:** <br>
- Docker Hub is like GitHub for Docker images. It’s a public registry where you can find and share Docker images.<br>
- You can pull official images *(like nginx, mysql, or python)* or push your own custom images to Docker Hub.<br>

<br>

---


### 2️⃣What is Docker-Compose?
Docker Compose is a tool used to easily manage and run multi-container applications.  <br>
Using a docker-compose.yml file, you can define and start all parts of your app *(web server, database, cache)* <br>
with a single command. *(Basiclly like a Makefile for docker)* <br>

<br>


---


### 3️⃣What are Multi-container Applications?
A multi-container application is an app that needs more than one Docker container to work.
- For example, let's say you have an e-commerce website. It might need:
    - A web server *(like Nginx or Apache)* to serve the website.
    - A database *(like MySQL or MongoDB)* to store user data.
    - A caching service *(like Redis)* to make things faster. <br>

Each of these components runs in its own container, but they work together to make the entire app function. <br>
This setup is called a multi-container application. <br> 

<br>


---


### 4️⃣What is a Docker Image?
A Docker image is like a blueprint or template for creating a Docker container.
- It contains everything needed to run an application, such as the code, libraries, and dependencies.
- When you start a container, it's created from a Docker image. <br>
 The image is read-only and acts as a recipe for how the container should be built. <br>

Think of a Docker image like a snapshot of your app environment that can be used <br>
to create multiple identical containers whenever you need. <br>

<br>

---


### 5️⃣What Are Volumes?
Docker containers are designed to be ephemeral *(short-lived)*, meaning that any data generated within <br>
the container during runtime will be lost once the container is stopped or removed. <br>
Volumes are used to persist important data outside of the container, <br>
allowing  you to keep that data even after the container is deleted or ontainer reboots <br>

**How volumes work:**
- Volumes are stored on the host machine outside the container’s filesystem, usually in */var/lib/docker/volumes/*.
- They allow data sharing between the host system and one or more containers.
- Volumes are independent of the container lifecycle, so data is safe even when the container is deleted or stopped. <br>

**Example Use Case:** <br>
Let’s say you’re running a database container like MySQL. <br>
You don’t want to lose your data every time the container stops. <br>
By using a volume, you can store the database data on your host machine, <br>
so that if you recreate the container, your data will still be there. <br>

**Example** how Volumes Are Defined in `docker-compose.yml`: <br>
```yaml
services:
    mariadb:
        [...]
        volumes: 
            - db_data:/var/lib/postgresql/data
    wordpress:
        [...]
    nginx:
        [...]

volumes:                                      
      mariadb:
            [...]                                             
                device: ${HOME}/data/db_data 

[...]
```

This means the database data is stored outside the container, <br>
and will be preserved even if the container is destroyed. 

<br>


---


### 6️⃣Virtual Machine vs Docker

**Summary of Differences:**

| Feature          | Virtual Machine (VM)                           | Docker (Container)                               |
| ---------------- | ---------------------------------------------- | ------------------------------------------------ |
| **Architecture**  | Full guest OS on top of host OS                | Shares host OS kernel, isolated by processes      |
| **Startup Speed** | Slow (minutes)                                 | Fast (seconds)                                   |
| **Resource Usage**| Heavy, each VM needs its own OS                | Lightweight, shares host OS                      |
| **Isolation**     | Full OS isolation (secure, but heavier)        | Process-level isolation, lighter but less isolated|
| **Portability**   | Less portable, larger images (full OS)         | Highly portable, smaller images                  |
| **Performance**   | Slower (due to full OS overhead)               | Faster (less overhead)                           |
| **Use Cases**     | Running multiple OSes, legacy apps, full OS isolation | Microservices, cloud apps, lightweight tasks  |
| **Size of Images**| Large (GBs)                                    | Small (MBs to GBs)                               |

<br>

**In Summary:**
- `Docker (containers)` is more lightweight, faster, and more efficient when running multiple applications on the same machine. <br>
 It's great for modern app development, where speed, portability, and scalability are key.
- `Virtual machines (VM)` offer more complete isolation and are better suited when you need to <br>
 run different operating systems or when full OS separation is required.

<br> 

---

<br>
<br>

## 🫖Set up your Virtual Machine

<details>
  <summary><strong>1️⃣How to set up your Virtual Machine</strong></summary>
  <br>

## 1️⃣How to set up your Virtual Machine

You can either use as OS Ubuntu or POP!_OS (Or something else).

### Step 1: <br>
&ensp; - [Downloading Ubuntu](https://ubuntu.com/) &ensp; OR &ensp; [Downloading POP!_OS](https://pop.system76.com/)

### Step 3: <br>
&ensp; - [Set up a VirtualBox with Ubuntu](https://www.youtube.com/watch?v=v1JVqd8M3Yc) &ensp; OR &ensp; [Set up a VirtualBox with POP!_OS](https://www.youtube.com/watch?v=NTK4a0sDgvA)

### Step 4: <br>
&ensp; - **Installing the Rest.** <br>
## Installation via Terminal:
``` bash
### Basic
sudo apt-get update
sudo apt-get upgrade
sudo apt-get install build-essential
sudo apt-get install git-all
sudo apt-get install clang
sudo apt-get -y install make
sudo apt-get install curl

### For Docker
sudo apt-get install apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
docker-compose --version
sudo apt-get install docker-ce
sudo systemctl status docker
sudo reboot

```

<br> <br>

</details>

<details>
  <summary><strong>2️⃣Create a shared folder</strong></summary>
  <br>


## 2️⃣Create a Shared Folder

This is for the Oracle VirtualBox.
Set up shared folders in VirtualBox to easily transfer files between the host and guest. <br> <br> 

- Go to VM `Settings` -> `Shared Folders`
- Click the `+` icon to add a new shared folder
- ***Folder Path:*** The path to the shared folder on you host *(Create before this step a folder on your host)*
- ***Folder Name:*** Name of the folder you created on the host *(Fill in should happen automatically)*
- ***Mount Point:*** `/mnt/shared`
- Set `Auto-mount` option 
- `OK`
- Start your VM
- Go to `Devices` -> `Insert Guest Additions CD image...`
- **'cd..'** till you find the `mnt` folder
- ```bash
  sudo mount -t vboxsf <foldername> /mnt/shared
  ```
   Replace `<foldername>` with the name you set for the shared folder.
- **'cd'** into `/mnt/shared` *(You will find all your folders in there)*
<br> <br>

</details>

<details>
  <summary><strong>3️⃣Connect to your host terminal</strong></summary>
  <br>


## 3️⃣Connect to your host terminal

Connecting to your VM through the terminal simplifies your workflow. <br>
It allows for easy copy-pasting, regular terminal is faster then VM-terminal, <br>
and feels just like working locally with VS Code and your regular terminal, <br>
NO NEED to switch between multiple tools.

### First: 
- Go to VM `Settings` **->** `Network` **->** `Advanced` **->** `Port Forwarding`<br>
- Click the `+` icon to add a new port <br>
***Host IP:*** 127.0.0.1 <br>
***Host Port:*** 2222 *(could be any port number)* <br>
***Guest Port:*** 22 *(default SSH port on the guest)* <br>

### Second:
In VM terminal: <br>
*(only for the first time connecting to the VM)*
```bash
sudo apt install openssh-server
sudo systemctl start ssh
```

### Third:
*(This command everytime you connect to the VM)*
```bash
ssh -p <port> <username>@127.0.0.1
```

### TEST:

``` bash
cd Desktop
touch IamHERE
```
&emsp;&emsp; **-> file should appear on your VM desktop** <br>

```bash
exit
```
&emsp;&emsp; **-> if you want to stop the connection** 

<br> <br>

</details>

<br> 

---

<br>
<br>


## 🫖Set Up

### 🍿Extra

<details>
  <summary><strong>.env</strong></summary>
  <br>

## 🧩.env:

The .env file allows you to keep configuration data separate from your codebase, <br>
making the application more flexible and easier to maintain. <br>
Instead of hardcoding values in your application, you can reference environment variables, <br>
which can be changed without altering the code. <br>
The variables in a .env often include sensitive or configuration-specific data, <br>
such as API keys, database credentials, or application settings. <br>
Sensitive information like passwords, API keys, and secrets should not be stored in your source code, <br>
so you store them in your .env to keep those secure. <br>

**For this projcet you can store:**
- Database connection details *(hostname, database name, credentials)*
- WordPress admin credentials (*for managing the site)*
- A regular user account *(for testing the site as a normal user)*

Ensure your .env file is in the same directory where you run the docker-compose command.<br>
Docker Compose looks for the .env file in the project directory by default.<br>

**Your .env file should look like this:** *(can ofcourese add more variables)*
```plaintext
# GENERAL
DOMAIN_NAME=[...]          # Intra user name

# DATABASES
WP_DATABASE_NAME=[...]     # Name of database that WordPress will use to store its data, which is wordpress
WP_DATABASE_HOST=[...]     # Name of the host database server for wordpress database, which is mariadb -> This is the service name used by Docker.

# MARIADB DATABASE
DB_ROOT_PASSWORD=[...]     # Root password your choice 
DB_USER=[...]              # User your choice
DB_USER_PASSWORD=[...]     # Password your choice  

# WORDPRESS ADMIN
WP_ADMIN=[...]             # Admin your choice
WP_ADMIN_PASSWORD=[...]    # Admin password your choice 
WP_ADMIN_EMAIL=[...]       # Admin email your choice

# WORDPRESS USER
WP_USER=[...]              # User your choice
WP_USER_PASSWORD=[...]     # Password your choice 
WP_USER_EMAIL=[...]        # Email your choice
```

<br> <br>

</details>

<details>
  <summary><strong>Dockerfile</strong></summary>
  <br>


## 🧩Dockerfile:

The Dockerfile is used to define the environment and dependencies required for your application.

**Example of a simple Dockerfile:**
```dockerfile
# Use a Debian base image
FROM debian:bookworm

# Set the working directory in the container
WORKDIR /path/app

# Install Python and any other required dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    python3 \
    python3-pip \

# # Copy the application files into the container : from '/path/app' to '/new/path/app'
COPY /path/app /new/path/app

# Command to run the application
CMD ["#!/bin/bash", "app.sh"] 
```

❗**NOTE:** <br>
`In Dockerfile:` <br>
&emsp;&emsp;&emsp;The RUN apt-get install command inside the Dockerfile runs as the root user by default, <br>
&emsp;&emsp;&emsp; which is why it works without any additional permissions. <br>
`In a Running Container:` <br>
&emsp;&emsp;&emsp;When you're trying to manually install something by running apt-get <br>
&emsp;&emsp;&emsp; in an already running container, you must ensure you're using the root user. 

<br> <br>

</details>

<details>
  <summary><strong>Docker-compose.yml</strong></summary>
  <br>

## 🧩Docker-compose.yml:


**#️⃣1. General Overview** <br>
This Docker Compose file defines a multi-container application that consists of three main services:
- MariaDB: The database service.
- Nginx: The web server that will serve the website.
- WordPress: The WordPress application itself. 
<br>

The volumes and networks help manage data persistence and network communication between these services. <br><br>

**#️⃣2. Version** <br>
The version key specifies the version of the Compose file format you're using.  <br>
But the newer Docker update doesn't require a version anymore, it will give you a warning. <br><br>

**#️⃣3. Services** <br>
The services key defines all the individual services *(containers)* that make up your application <br>
that will work together to create a multi-container environment.  <br>
Each service runs in its own container and represents a specific part of your application. <br>
Under services, you define three services:` mariadb`,` nginx`, and `wordpress`. <br>
Each one represents a different container that is built and managed by Docker Compose. <br><br>

&emsp;&emsp;***Breakdown of services*** <br>
&emsp;&emsp;`mariadb:` <br>
&emsp;&emsp;This service defines a MariaDB container *(the database)*. <br>
&emsp;&emsp;It will be used to store and serve data for your WordPress application. <br>
&emsp;&emsp;`nginx:` <br>
&emsp;&emsp;This service defines an Nginx container *(the web server)*. <br>
&emsp;&emsp;Nginx acts as a reverse proxy that handles web traffic and directs it to the WP service. <br>
&emsp;&emsp;`wordpress:` <br>
&emsp;&emsp;This service defines a WordPress container *(the application)*. <br>
&emsp;&emsp;It will run the actual WordPress site, and it depends on the MariaDB for data storage. <br> <br>

**#️⃣4. Services Section** <br>
For each component, you define a service. <br>
A service represents a container and its associated configuration.<br>

&emsp;`Image:` What Docker image will be used *(e.g., mariadb, wordpress, or nginx)*? <br>
&emsp;`Build:` If you need a custom image, you specify a build section that <br>
&emsp;&emsp;&emsp;&emsp;&emsp;tells Docker Compose where to find the Dockerfile. <br>
&emsp;`Environment Variables:` What configuration does the container need at runtime? <br>
&emsp;&emsp;&emsp;&emsp;&emsp;For instance, databases need credentials. <br>
&emsp;`Volumes:` Do you need to store data persistently or <br>
&emsp;&emsp;&emsp;&emsp;&emsp;share files between the container and the host? *(what ports to expose)* <br>
&emsp;`Ports:` Which ports need to be mapped between the host and the container? <br>
&emsp;`Network:` Do the containers need to communicate which each other? <br><br>

**#️⃣5. Environment Variables** <br>
Environment variables are commonly defined in a .env file for ease of management and security. <br><br>
**When using a .env file, you can reference it in your docker-compose.yml as:** <br>
```yml
env_file:
    - .env
```

But lets say yo don't have a .env file or you have variables that are executed after runtime. <br>
**You add the to your server like this:** <br>
```yml
environment:
      DOMAIN_NAME: ${DOMAIN_NAME}
      DB_USER: ${DB_USER}
      DB_USER_PASSWORD: ${DB_USER_PASSWORD}
```
**OR**
```yml
environment:
      DOMAIN_NAME: John_example
      DB_USER: John
      DB_USER_PASSWORD: john123
```
<br>

**Difference Between `args` and `environment`:**

1. ***args (Build Arguments):*** <br>
- Build-time variables used exclusively during the image build process *(via docker build or docker-compose build)*.
- Defined in the build section of docker-compose.yml and accessed using ARG in a Dockerfile.
- Once the image is built, these values are no longer accessible. <br><br>

2. ***environment:*** <br>
- Runtime variables available to the container during execution.
- These can be defined in docker-compose.yml, and accessed using ENV in a Dockerfile.
- Accessible to the application within the container via environment variable methods. <br>

In summary, args are temporary and limited to the image build process, <br>
while environment variables are persistent during the container's runtime and directly influence the application's behavior. <br><br>
**Example:**
```plaintext
                     -------- ARG --------

       Docker-Compose.yml:     |            Dockerfile:                  
    -----------------------------------------------------------
mariadb:                       |    FROM debian:buster
  build:                       |        
    context: src/mariadb       |    EXPOSE 9000 
    args:                      |    
      DB_USER: ${DB_USER}      |    ARG DB_USER
      [...]                    |    ARG [...]
                               |


                     -------- ENV --------

       Docker-Compose.yml:     |            Dockerfile:
    -----------------------------------------------------------
mariadb:                       |    FROM debian:buster
  build:                       |        
  context: src/mariadb         |    EXPOSE 9000 
  environment:                 |    
    DB_USER: ${DB_USER}        |    ENV DB_USER
    [...]                      |    ENV [...]
                               |  
```
<br>

**#️⃣6. Volumes** <br>
Volumes ensure that critical data *(like the MariaDB database and WordPress content)* persists across container restarts.
- MariaDB Volume *(mariadb:/var/lib/mysql)*: <br>
  - Reason: MariaDB stores the actual database files in /var/lib/mysql within the container. <br>
    &emsp;&emsp;&emsp;By binding this to a host directory, you ensure that your databases <br>
    &emsp;&emsp;&emsp;are persistent across container restarts. <br>
    &emsp;&emsp;&emsp;Without this, any database data would be lost when the container stops.<br>
- WordPress Volume *(wordpress:/var/www/html)*: <br>
  - Reason: WordPress stores files such as themes, plugins, and uploads in /var/www/html.<br> 
    &emsp;&emsp;&emsp;By binding this directory to the host, <br>
    &emsp;&emsp;&emsp;your WordPress website's content persists even when <br>
    &emsp;&emsp;&emsp;the container is restarted or removed.<br>
- Nginx Volume *(nginx:/var/www/html)*: (NOT NECESSARY) <br>
  - Optional Use Case: If you need to store static files, custom configurations, or logs, you can bind mount a directory for Nginx. <br>
    &emsp;&emsp;&emsp;Since you're using WordPress and Nginx is just serving it, <br>
    &emsp;&emsp;&emsp;this may not be necessary unless you're doing something <br>
    &emsp;&emsp;&emsp;like custom Nginx configurations.<br><br>

**#️⃣7. Networks**<br>
Networks allow your containers to communicate with each other <br>
internally on a dedicated Docker network.<br> <br>
**All three containers should have:**
```yaml
services:
  mariadb:
    [...]
    networks:
      - inception        # Connect MariaDB to the "inception" network

  nginx:
    [...]
    networks:
      - inception        # Connect Nginx to the "inception" network

  wordpress:
    [...]
    networks:
      - inception        # Connect WordPress to the "inception" network

networks:                # Network configuration
      inception:
        [...]
```

This setup provides a robust architecture for running a WordPress site backed by MariaDB with Nginx acting as a reverse proxy, <br>
ensuring data persistence and internal communication. <br>

***Why do you need a custom network?*** <br>
- `Internal Communication:` <br>
  - All services in your Compose file *(mariadb, nginx, and wordpress)* <br>
    are connected to the inception network.  <br>
  - This allows the services to communicate internally using container names as hostnames. <br>
- `Easy Service Discovery:` <br>
  - Docker automatically provides service discovery on custom networks.  <br>
  - **For example**, in your WordPress container, if you set DB_HOSTNAME: mariadb, Docker will <br>
    know to resolve mariadb to the correct container's IP address because both services <br>
    are on the same inception network. <br>

<br>

<details>
  <summary><strong>❇️❇️Example docker-compose.yml❇️❇️</strong></summary>

## Example docker-compose.yml:

```yaml
version: "3.8"                                     # can leave this away

services:
    mariadb:
        container_name: mariadb                    # Names the container "mariadb" for easier reference
        image: mariadb                             # Pulls the official MariaDB image
        build: 
            context: requirements/mariadb          # Builds the image from a Dockerfile located in "requirements/mariadb"
        environment:
            DOMAIN_NAME: ${DOMAIN_NAME}            # Passes environment variables to the build process
            DB_USER: ${DB_USER}
            DB_USER_PASSWORD: ${DB_USER_PASSWORD}
        restart: unless-stopped                    # Restarts the container automatically unless explicitly stopped
        env_file:
            - .env                                 # Loads environment variables from the ".env" file
        volumes:
            - mariadb:/var/lib/mariadb             # Binds the host directory to the MariaDB data directory inside the container.
        networks:
            - inception                            # Connects to the "inception" network, allowing it to communicate with other services
    nginx:
        container_name: nginx                      # Names the container "nginx"
        image: nginx                               # Uses the official Nginx image
        build: requirements/nginx                  # Builds the image from a Dockerfile in "requirements/nginx"
        depends_on:
            - wordpress                            # Ensures that the "wordpress" service is started before "nginx"
        restart: unless-stopped                    # Restarts the container unless explicitly stopped
        env_file:
            - .env                                 # Loads environment variables from the ".env" file
        ports:
            - "443:443"                            # Exposes port 443 for HTTPS traffic
        volumes:
            - nginx:/var/www/html                  # Binds the host directory to the Nginx data directory inside the container.
        networks:
            - inception                            # Connects to the "inception" network, allowing it to communicate with other services
    wordpress:
        container_name: wordpress                  # Names the container "wordpress"
        image: wordpress                           # Uses the official WordPress image
        build:
            context: requirements/wordpress        # Builds the image from a Dockerfile located in "requirements/wordpress"
        environment:
            DOMAIN_NAME: ${DOMAIN_NAME}            # Passes environment variables to the build process
            DB_USER: ${DB_USER}
            DB_USER_PASSWORD: ${DB_USER_PASSWORD}
        env_file:
            - .env                                 # Loads environment variables from the ".env" file
        restart: unless-stopped                    # Restarts the container unless explicitly stopped
        depends_on:
            - mariadb                              # Ensures that MariaDB is started before WordPress
        volumes:
            - wordpress:/var/www/html              # Binds the WordPress files directory from the host to the container. 
        networks:
            - inception                            # Connects to the "inception" network, allowing it to communicate with other services

# Network configuration
networks:
    inception:
        name: inception                            # Defines a custom bridge network named "inception" to allow communication between containers.

# Volumes configuration to persist data
volumes:
    mariadb:
        name: mariadb                              # Defines the volume name as "mariadb"
        driver: local                              # Volume is located on the local host system
        driver_opts:
            type: none                             # No special filesystem type is enforced
            o: bind                                # Bind mounts the host directory to the container
            device: $(HOME/data/mariadb            # This is the host directory where MariaDB will persist its database files
    wordpress:
        name: wordpress                            # Defines the volume name as "wordpress"
        driver: local                              # Volume is located on the local host system
        driver_opts:
          type: none                               # No special filesystem type is enforced
          o: bind                                  # Bind mounts the host directory to the container
          device: ${HOME/data/wordpress            # This is the host directory where WordPress fwill persist its database files
```
<br>

</details>

<br>

</details>


<details>
  <summary><strong>Docker Compose Commands</strong></summary>

## 🧩Docker Compose Commands:

***1. Common Docker Compose Commands***
  - Start Services Without Rebuilding: <br>
    ```docker-compose up -d```
  - Start With Rebuilding: <br>
    ```docker-compose up --build -d```
  - Stop Services Without Removing Containers: <br>
    ```docker-compose stop```
  - View Service Logs: <br>
    ```docker-compose logs```
  - Restart Services: <br>
    ```docker-compose restart```
  - List Running Containers: <br>
    ```docker-compose ps```

***2. Advanced Docker Compose Commands***
  - Check Configuration: <br>
    ```docker-compose config```
  - List Networks: <br>
    ```docker network ls```
  - Inspect a Network: <br>
    ```docker network inspect <network_name>```
  - Remove Unused Networks: <br>
    ```docker network prune```

***3. Docker Commands for Containers***
  - View Running Containers: <br>
    ```docker ps```
  - List all containers *(including stopped ones)*: <br>
    ```docker ps -a```
  - Inspect a Container: <br>
    ```docker inspect <container_name>```
  - List Docker Volumes: <br>
    ```docker volume ls```
  - Inspect a Volume: <br>
    ```docker volume inspect <volume_name>```
  - Remove Unused Volumes: <br>
    ```docker volume prune```

***4. Debugging and Troubleshooting***
  - View Container Logs: <br>
    ```docker logs <container_name>```
  - Attach your terminal to a running container: <br>
    ```docker attach <container_name>```
  - View Open Ports: <br>
    ```docker port <container_name>```
  - Kill a Misbehaving Container: <br>
    ```docker kill <container_name>```
  - Remove Unused Images: <br>
    ```docker image prune -a```
  - View Disk Usage: <br>
    ```docker system df```
  - Remove Dangling Images: <br>
    ```docker image prune```

<br>
</details>

---




### 🍿MariaDB


---


### 🍿WordPress


---


### 🍿Nginx


<br> 

---

<br>
<br>

## 🫖Installation
To execute the program, follow the steps below:

***1. Add DOMAIN_NAME to '/etc/hosts':***
  - Sudo nano /etc/hosts
  - add line "127.0.0.1 <DOMAIN_NAME>"
  - save

***2. start the 'docker-compose' through the makefile by running the following command:***
```bash
$ make
```
***3. Go to your web browser*** *(Chrome, Firefox ...)*
```bash
<DOMAIN_NAME>
```
&emsp;&emsp;***OR***
```bash
https://<DOMAIN_NAME>
```
`DOMAIN_NAME` is defined in the .env file.
<br>

<br> 

---

<br>
<br>

## 🫖Resources

***Docker:***
- [Docker Compose Documentation](https://docs.docker.com/compose/)
- [Multi-Container Applications](https://docs.docker.com/get-started/docker-concepts/running-containers/multi-container-applications/)
- [Docker Volumes](https://docs.docker.com/engine/storage/volumes/)
- [Docker Daemon](https://www.geeksforgeeks.org/what-is-docker-daemon/)
- [Docker Overview](https://docs.docker.com/get-started/docker-overview/)
- [GitHub ReadME](https://github.com/Forstman1/inception-42/blob/main/README.md)

***Wordpress:***
- [WordPress Docker Setup](https://www.datanovia.com/en/lessons/wordpress-docker-setup-files-example-for-local-development/)
- [WordPress and Dockerfiles](https://www.massolit-media.com/tech-writing/wordpress-and-docker-dockerfiles/)
- [WordPress `wp-config`](https://developer.wordpress.org/advanced-administration/wordpress/wp-config/)
- [WordPress Deployment](https://medium.com/swlh/wordpress-deployment-with-nginx-php-fpm-and-mariadb-using-docker-compose-55f59e5c1a)

***MariaDB:***
- [MariaDB Custom Container Image](https://mariadb.com/kb/en/creating-a-custom-container-image/)

***Nginx:***
- [NGINX Docker Image](https://www.docker.com/blog/how-to-use-the-official-nginx-docker-image/)


































 
- Mariadb
  
 <!-- 

# MariaDB
To set up a MariaDB container with custom configuration, you would typically need:
- `Dockerfile` : This defines the MariaDB image build, installing any necessary tools and copying configuration files into the container.
- `Initialization Script (db-script.sh)` : This script initializes the database, sets up users, databases, and permissions, and ensures that MariaDB keeps running in the foreground.
- `Custom Configuration File (config.cnf) `: This file customizes MariaDB’s server settings, like port, bind address, caching, logging, and character sets.

### dockerfile ---------------------------------
- Use Debian as a base image (FROM)
- Update & intstall your package manager (RUN)
- Copy custom MariaDB configuration script AND config.cnf (COPY) 
- Expose port 3306 (EXPOSE)
- Run the MariaDB setup script and start the server in the foreground (CMD)

### --------------------------------------------
### script -------------------------------------
Such a script usually takes care of preparing the environment, initializing the database if necessary, setting up security configurations, creating a database, and ensuring MariaDB runs in the foreground.

Let's go through this MariaDB initialization script step by step:
This is the "shebang" line. It tells the system that the script should be executed using /bin/bash, a common Unix shell.
You alway need this line at the top of your script.sh
```bash
#!/bin/bash
```
- Create Necessary Directories and Set Permissions:
MariaDB requires specific directories for data and logs. The script should create these directories and adjust permissions to ensure that the MariaDB process has access to them.
- Check if the Database Directory Exists:
The script checks if the MariaDB data directory is already initialized. If not, it initializes the database.
      - Secure MariaDB Installation:
        This step usually involves securing the MariaDB installation, similar to the interactive mysql_secure_installation command.
        This script segment automates the security questions asked during the mysql_secure_installation. Options include:
            - Setting a root password
            - Removing anonymous users
            - Disallowing root login remotely
            - Removing the test database
            - Reloading privilege tables
        Note: Replace "password" with a secure password of your choice.
      - Create a New Database (if specified):
        If you want to create a new database, you can add a check and run the necessary SQL command.
      - Create a New User and Grant Privileges (if specified):
        If a user and password are provided, the script creates the user and grants the necessary privileges.
            - CREATE USER: Adds a new user with a specified password.
            - GRANT ALL PRIVILEGES: Gives the new user full access to the specified database.
            - FLUSH PRIVILEGES: Refreshes the privilege tables to apply changes.
- Keep MariaDB Running in the Foreground:
To ensure the database service stays active in the foreground (important for containerized environments like Docker).
            - `exec mysqld` replaces the current shell process with the MariaDB server, keeping it running in the foreground.




### --------------------------------------------
### config.cnf --------------------------

The custom_config.cnf file is a configuration file for the MariaDB server, specifically for setting server-side options that control database behavior, storage, networking, and performance. Let’s break down 
You can find an example of an config.cnf here [ibm](https://www.ibm.com/docs/en/ztpf/2023?topic=performance-mariadb-configuration-file-example) or here (github)[https://gist.github.com/fevangelou/fb72f36bbe333e059b66].
Just uncommand the lines you don't need.

the main sections and settings:

# Structure of the Configuration File
1) Sections:
Configuration files are organized into sections. Each section starts with a name in square brackets, such as [server], [mysqld], [embedded], etc. The parameters defined under each section apply to that specific component of MariaDB.
2) Key-Value Pairs:
Each setting is defined as a key-value pair, where the key is the configuration option, and the value specifies its setting.

# 1) Sections: General Server Configuration Sections
The configuration file is divided into sections (like [mysqld], [mariadb], etc.) that specify settings for different components of the MariaDB server. Each section can contain specific settings related to that component.
- `[server]` : This section applies to the entire MariaDB server, both for standalone and embedded servers.
- `[mysqld]` : Settings in this section apply only to the mysqld standalone MariaDB server daemon.
- `[embedded]`, `[mariadb]`, `[mariadb-10.3]` : These sections define options specific to embedded servers, MariaDB-specific options, and MariaDB version-specific settings, respectively.

# 2) Key-Value Pairs: Basic Settings
# User and PID file settings
- `user` : Sets the user under which the MariaDB server runs.
- `pid-file` : Path for the PID file, which helps manage the MariaDB process.

# Socket and Port settings
- `socket` : Location of the MariaDB Unix socket file for local connections.
- `port` : Sets the port for TCP/IP connections (default MySQL/MariaDB port).

# Directories settings
- `basedir` : Base directory where MariaDB is installed.
- `datadir` : Directory for storing database files.
- `tmpdir` : Temporary files directory used by the server.
- `lc-messages-dir` : Directory for error messages and translations.

# Network settings
- `bind-address` : Specifies the network interface on which MariaDB listens for incoming connections. Setting this to 0.0.0.0 means it accepts connections from all interfaces.

# Fine Tuning
This section contains various parameters that can fine-tune the performance of the server.
Example parameters:
- `key_buffer_size        = 16M`
- `max_allowed_packet     = 16M`
- `thread_stack           = 192K`
- `thread_cache_size      = 8`
- `myisam_recover_options = BACKUP`
- `max_connections        = 100`
- `table_cache            = 64`
- `thread_concurrency     = 10`

# Query Cache Configuration
- `query_cache_size` : Size of the query cache, which stores results of queries to improve performance.

# Logging and Replication
- `log_error` : Path to the error log file, which is crucial for troubleshooting.
- `expire_logs_days` : Number of days to keep binary logs before they are automatically removed.

# Settings for general logging and slow query logging if desired:
- `general_log_file       = /var/log/mysql/mysql.log`
- `general_log            = 1`
- `slow_query_log_file    = /var/log/mysql/mariadb-slow.log`
- `long_query_time        = 10`
- `log_slow_rate_limit    = 1000`
- `log_slow_verbosity     = query_plan`
- `log-queries-not-using-indexes`

# Replication setup
- `server-id              = 1`
- `log_bin                = /var/log/mysql/mysql-bin.log`
- `max_binlog_size        = 100M`
- `binlog_do_db           = include_database_name`
- `binlog_ignore_db       = exclude_database_name`

# Security Features
Security configurations related to connections and SSL.
Uncomment and configure if required.
- `chroot = /var/lib/mysql/`
- `ssl-ca = /etc/mysql/cacert.pem`
- `ssl-cert = /etc/mysql/server-cert.pem`
- `ssl-key = /etc/mysql/server-key.pem`
- `ssl-cipher = TLSv1.2  # Ensure the latest TLS protocol is used for secure connections.`

# Character Sets
Character set settings to support various languages and symbols.
- `character-set-server` : Defines the default character set for the server.
- `collation-server` : Defines the default collation for string comparison.

# Unix Socket Authentication Plugin
This is for Unix socket authentication, allowing the root user to authenticate without a password when running as the Unix root user.
See https://mariadb.com/kb/en/unix_socket-authentication-plugin/ for details.

# this is only for embedded server
[embedded]

# This group is only read by MariaDB servers, not by MySQL.
# If you use the same .cnf file for MySQL and MariaDB,
# you can put MariaDB-only options here.
[mariadb]

# This group is only read by MariaDB-10.3 servers.
# If you use the same .cnf file for MariaDB of different versions,
# use this group for options that older servers don't understand.
[mariadb-10.3]





```

### --------------------------------------------
### Test MariaDB -------------------------------
Navigate to the directory containing your `docker-compose.yml` and run the following command:

RUN:
- Build your container
- View Logs: (fix them first)
```bash
docker-compose logs mariadb
```
- Accessing the MariaDB Instance:
Might need to install `sudo apt install mysql-client`
```bash
mysql -u <DB_USER> -p
```
-> If everything works till here your database is running 
- 1. Verify Database and User Creation:
```sql
# SHOW DATABASES;
```
-> Make sure your database (your_database_name) is listed. 
-> Should look like:
```sql
mysql> SHOW DATABASES;
+--------------------+
| Database           |
+--------------------+
| information_schema |
| mysql              |
| performance_schema |
| sys                |
| wordpress          |
+--------------------+
5 rows in set (0.00 sec)
```

- 2. Check if your user is created with the right permissions:
```sql
# SELECT host, user FROM mysql.user;
```
-> This should list your USER.
-> Should look like:
```sql
mysql> SELECT host, user FROM mysql.user;
+-----------+-------------+
| Host      | User        |
+-----------+-------------+
| %         | bob         |
| %         | root        |
| 127.0.0.1 | healthcheck |
| ::1       | healthcheck |
| localhost | healthcheck |
| localhost | mariadb.sys |
| localhost | root        |
+-----------+-------------+
7 rows in set (0.00 sec)
```

- 3. To confirm the user's permissions:
```sql
# SHOW GRANTS FOR '<USER>'@'%';
```
If the USER does not have the correct permissions:
-> Should look like:
```sql
mysql> SHOW GRANTS FOR 'bob'@'%';
+----------------------------------------------------------------------------------------------------+
| Grants for bob@%                                                                                   |
+----------------------------------------------------------------------------------------------------+
| GRANT USAGE ON *.* TO `bob`@`%` IDENTIFIED BY PASSWORD '*61584B76F6ECE8FB9A328E7CF198094B2FAC55C7' |
+----------------------------------------------------------------------------------------------------+
1 row in set (0.00 sec)
```
- 4. Correct Any Issues with User Permissions
```sql
# GRANT ALL PRIVILEGES ON `<your_database_name>`.* TO '<USER>'@'%' IDENTIFIED BY '<your_password>';
# FLUSH PRIVILEGES;
```
-> Should look like:
```sql
mysql> GRANT ALL PRIVILEGES ON `mariadb`.* TO 'bob'@'%' IDENTIFIED BY 'bob';
Query OK, 0 rows affected (0.01 sec)

mysql> FLUSH PRIVILEGES;
Query OK, 0 rows affected (0.00 sec)
```
















# MySQL Server Configuration File

[server]
# General server settings can be placed here. This section is commonly left blank
# because most configurations are defined under the `[mysqld]` section.

[mysqld]
# Settings for the MySQL daemon (server).

user                    = mysql               # The user under which the MySQL server runs.
pid-file                = /run/mysqld/mysqld.pid # File containing the process ID of the MySQL server.
socket                  = /var/run/mysqld/mysqld.sock # Unix socket for local connections.
port                    = 3306                # Port for MySQL to listen on (default is 3306).
basedir                 = /usr                # Base directory of the MySQL installation.
datadir                 = /var/lib/mysql      # Directory where MySQL data files are stored.
tmpdir                  = /tmp                # Temporary directory used for operations like sorting.
lc-messages-dir         = /usr/share/mysql    # Directory containing language files for error messages.
bind-address            = 0.0.0.0             # Listen on all network interfaces to allow external connections.
query_cache_size        = 16M                 # Amount of memory allocated for caching query results.
log_error               = /var/log/mysql/error.log # File to store error logs.
log-bin                 = /var/log/mysql/mysql-bin.log # Binary log file for replication and recovery.
expire_logs_days        = 10                  # Automatically remove binary logs older than 10 days.
character-set-server    = utf8mb4             # Default character set for the server.
collation-server        = utf8mb4_general_ci  # Default collation for the server.
innodb_use_native_aio   = 0                   # Disable native asynchronous I/O (useful for certain environments).

[client]
# Configuration for MySQL client tools.

default-character-set = utf8mb4               # Default character set for client connections.

[embedded]
# Settings for embedded MySQL server (if used). Typically left blank unless embedding is required.

[mariadb]
# Specific settings for MariaDB server. This section can be used for MariaDB-specific configurations.

[mariadb-10.3]
# Settings specific to MariaDB version 10.3. This section allows version-specific configurations.

















MariaDB:
WordPress relies on a database to store its data. The MariaDB container provides this, so it needs to be up and running first.
This ensures WordPress can connect to the database as soon as it starts.






What Does --bootstrap Do?
The --bootstrap option is a special mode for MariaDB's server process (mysqld) that:

Starts the server without networking or any background services.
Allows initialization scripts to run within a safe, minimal environment.
Automatically exits after processing the commands.
It is typically used for initial setup tasks like:

Setting up system databases (mysql, information_schema, etc.).
Creating or configuring initial users and permissions.
Avoiding unnecessary overhead or conflicts during first-time setup.
Why Use --bootstrap?
Efficiency: The server is started in a lightweight mode without overhead from networking, plugins, or other features unnecessary during initialization.
Isolation: No external connections or conflicts occur during setup.
Automation: It’s a safe way to run one-time initialization scripts programmatically without starting the full server.






https://docs.docker.com/compose/
https://docs.docker.com/get-started/docker-concepts/running-containers/multi-container-applications/
https://docs.docker.com/engine/storage/volumes/
https://www.geeksforgeeks.org/what-is-docker-daemon/
https://docs.docker.com/get-started/docker-overview/
https://github.com/Forstman1/inception-42/blob/main/README.md
https://mariadb.com/kb/en/creating-a-custom-container-image/
https://www.datanovia.com/en/lessons/wordpress-docker-setup-files-example-for-local-development/
https://www.massolit-media.com/tech-writing/wordpress-and-docker-dockerfiles/
https://www.docker.com/blog/how-to-use-the-official-nginx-docker-image/
https://developer.wordpress.org/advanced-administration/wordpress/wp-config/
https://medium.com/swlh/wordpress-deployment-with-nginx-php-fpm-and-mariadb-using-docker-compose-55f59e5c1a











```

-->
  
- Wordpress

 <!-- 

# wordpress

### dockerfile ----------------------------------
- Use Debian as a base image (Debian 12)
- Update & intstall your package manager (RUN)
- Copy `wp-config.php` & `wp-script.sh` script from 'tools' directory into the container’s root directory (/). (COPY)
- Make sure the script is executable (NOT necessary for 'wp-config.php', since PHP just reads it) (RUN)
- Expose port 9000 (EXPOSE)
- Start PHP-FPM and run the custom WordPress script (CMD)




The issue where the mysqladmin command cannot be found suggests that mysql-client is still not installed or correctly configured in your WordPress Docker container.
The error you're encountering indicates that the mysql-client package is unavailable in the Debian 12 (Bookworm) repositories, which is causing the apt-get command to fail during the build process. Specifically, the package mysql-client is no longer available under that name in newer versions of Debian, including Bookworm.

Solution: Use the Correct MySQL Client Package
In recent versions of Debian, the MySQL client package has been replaced with mariadb-client. Since you are using MariaDB in your stack, the correct package to install would be mariadb-client instead of mysql-client.
### --------------------------------------------



is it okay that this is happening now in the dockerfile instead of the script.sh?
# Download WP-CLI directly into the /usr/local/bin directory
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp
ChatGPT said:
ChatGPT
Yes, it's perfectly fine—and actually quite good practice—to move the WP-CLI installation steps to the Dockerfile instead of handling them in script.sh. Here’s why this adjustment is beneficial:

Efficiency: By including WP-CLI installation in the Dockerfile, Docker caches this step in the image. This way, WP-CLI doesn't have to be downloaded each time you start a new container, which speeds up container startup.

Cleaner Script: script.sh now focuses only on the WordPress setup and configuration tasks, making it simpler and easier to debug.

Reduced Network Dependency: Since the WP-CLI download and installation occur during the build phase, this step only needs internet access once. Future builds and deployments of this container won't rely on the WP-CLI download server, which improves reliability.

Revised Dockerfile and Script Overview
With the WP-CLI installation in the Dockerfile, here’s a streamlined flow:

Dockerfile: Installs the necessary dependencies and downloads WP-CLI. This creates a reliable base image with everything WordPress needs.
script.sh: Uses WP-CLI to configure and start WordPress, now assuming WP-CLI is already installed and available.
In summary, this approach is both robust and more efficient. Your current setup looks good—let it build and run, and watch for any further configuration logs to confirm everything's working end-to-end!



3. Fix the PHP-FPM executable issue
The error /wp-script.sh: line 45: /usr/sbin/php-fpm7.4: No such file or directory indicates that the php-fpm7.4 executable doesn't exist. This may happen because the version specified (php-fpm7.4) is not installed in your container.

Instead of using php-fpm7.4, simply use php-fpm (which will default to the latest installed version of PHP-FPM). Update your wp-script.sh to use this:

bash
Copy code
exec /usr/sbin/php-fpm -F
This will start PHP-FPM without specifying a version number, ensuring it uses the installed PHP-FPM version.



Important Considerations:

Make sure that your wp-script.sh does two critical things:
Install and Configure WordPress: Download WordPress, configure database credentials (through wp-config.php), and ensure that WordPress files are in the right place.
Start PHP-FPM: It should start the php-fpm process to handle incoming PHP requests. If php-fpm isn't started, the container will not be able to serve any requests.
Example of wp-script.sh:
bash
Copy code
#!/bin/bash

# Download and unpack WordPress if not already present
if [ ! -f /var/www/html/wp-config.php ]; then
  echo "Downloading WordPress..."
  curl -O https://wordpress.org/latest.tar.gz
  tar -xzf latest.tar.gz -C /var/www/html --strip-components=1
  rm latest.tar.gz
  echo "WordPress downloaded and extracted."
fi

# Move the custom wp-config.php into place
mv /wp-config.php /var/www/html/wp-config.php

# Start PHP-FPM in the foreground
echo "Starting PHP-FPM..."
php-fpm7.4 -F
Explanation of the Script:
Download and Extract WordPress:

It checks if wp-config.php already exists in the /var/www/html directory (where WordPress files should reside). If it doesn't, the script downloads and extracts WordPress.
Move wp-config.php:

This moves your custom wp-config.php to the correct location inside the WordPress directory (/var/www/html).
Start PHP-FPM:

The php-fpm7.4 -F command starts the php-fpm service and keeps it running in the foreground (-F). This is essential for the container to keep running and handle PHP requests.


could i also do this?
CMD ["/wp-script.sh"]

instead of this 
CMD ["/bin/bash", "/wp-script.sh"]?

ChatGPT said:
ChatGPT
Yes, you can use the following:

dockerfile
Copy code
CMD ["/wp-script.sh"]
Key Differences and Considerations:
Direct Execution vs. Using Bash:

CMD ["/wp-script.sh"]: This attempts to run the wp-script.sh directly. For this to work, the script needs to have a proper "shebang" (#!/bin/bash or #!/bin/sh) at the top. The shebang tells the system which interpreter (like bash or sh) to use when running the script. If the shebang is missing, the system may not know how to execute the script.

Example of a proper shebang at the start of the script:

bash
Copy code
#!/bin/bash
CMD ["/bin/bash", "/wp-script.sh"]: This explicitly runs the script with bash. Even if the shebang is missing or if the script isn’t marked executable, this ensures the script is run by bash.

When to use each:

Use CMD ["/wp-script.sh"] if:
Your script has a proper shebang (#!/bin/bash or #!/bin/sh) at the top.
The script is marked executable (chmod +x /wp-script.sh).
Use CMD ["/bin/bash", "/wp-script.sh"] if:
You want to ensure the script runs with bash no matter what.
You don’t need the script to be executable (though it's still a good practice to make it executable).

### --------------------------------------------
### wp-config.php ------------------------------

```php
<?php
/**
 * The base configuration for WordPress
 *
 * The wp-config.php creation script uses this file during the
 * installation. You don't have to use the web site, you can
 * copy this file to "wp-config.php" and fill in the values.
 *
 * This file contains the following configurations:
 *
 * * MySQL settings
 * * Secret keys
 * * Database table prefix
 * * ABSPATH
 *
 * @link https://wordpress.org/support/article/editing-wp-config-php/
 *
 * @package WordPress
 */

// ** MySQL settings - You can get this info from your web host ** //
/** The name of the database for WordPress */
define( 'WP_DATABASE_NAME', 'db1' );

/** MySQL database username */
define( 'DB_USER', 'user' );

/** MySQL database password */
define( 'DB_USER_PASSWORD', 'pwd' );

/** MySQL hostname */
define( 'DB_HOST', 'mariadb' );

/** Database Charset to use in creating database tables. */
define( 'DB_CHARSET', 'utf8' );

/** The Database Collate type. Don't change this if in doubt. */
define( 'DB_COLLATE', '' );

define( 'WP_ALLOW_REPAIR', true );

/**#@+
 * Authentication Unique Keys and Salts.
 *
 * Change these to different unique phrases!
 * You can generate these using the {@link https://api.wordpress.org/secret-key/1.1/salt/ WordPress.org secret-key service}
 * You can change these at any point in time to invalidate all existing cookies. This will force all users to have to log in again.
 *
 * @since 2.6.0
 */
define( 'AUTH_KEY',         '):Uw9 :|7$m3yy=c^IM%d8}zG6yXY%25SDUyr.r#GcDP)[b25Yn$sDLNwR~I=kwq' );
define( 'SECURE_AUTH_KEY',  'lBWxAzhu=StQ(s-[t_D8yH8_`0NiM~d[m q<{Hri]n#UM3J;@x[ne;,k<~cN`~%,' );
define( 'LOGGED_IN_KEY',    ' /e+%ecWs`>hA<s`|+7rmujt>3MA}GD*n=D7W%$8h*Xc!jP?hn+fw0#;;g{Ywl@k' );
define( 'NONCE_KEY',        ' -cX{xQc|GjD$=kXd,|lUX5)*oT)ru3^px-iU{q;`1If22EqIwA0/lPIIbpbtB=C' );
define( 'AUTH_SALT',        'U9LX s1@q6$[*VV,MUhL7tS@;I9t_u*uDQIfZdG.ei1Amy$*.RI_TSTz#y=X.>Wq' );
define( 'SECURE_AUTH_SALT', '0<MR&l4v=cZ)8Ke/#ip>2<Ed@ j<#pvLaOMc-jEFM9^tr`X*T2qDIB@)gg.0<e2V' );
define( 'LOGGED_IN_SALT',   'xSHh4B]r[~)h%n$f(dCt;mD}#q gy$<{ >qGgPS>XH*]jH>W<!10>H<_16l{(OdP' );
define( 'NONCE_SALT',       '7Ea$kvU|lkO8&X]b7^#K+w! lH2)SOelLiaYYX(Zz)Ebk_]-#m,J&aM<*JedFa| ' );

define( 'WP_REDIS_HOST', 'redis' );
define( 'WP_REDIS_PORT', 6379 );     


define('WP_CACHE', true);

/**#@-*/

/**
 * WordPress Database Table prefix.
 *
 * You can have multiple installations in one database if you give each
 * a unique prefix. Only numbers, letters, and underscores please!
 */
$table_prefix = 'wp_';

/**
 * For developers: WordPress debugging mode.
 *
 * Change this to true to enable the display of notices during development.
 * It is strongly recommended that plugin and theme developers use WP_DEBUG
 * in their development environments.
 *
 * For information on other constants that can be used for debugging,
 * visit the documentation.
 *
 * @link https://wordpress.org/support/article/debugging-in-wordpress/
 */
define( 'WP_DEBUG', true );

/* That's all, stop editing! Happy publishing. */

/** Absolute path to the WordPress directory. */
if ( ! defined( 'ABSPATH' ) ) {
	define( 'ABSPATH', __DIR__ . '/' );
}

/** Sets up WordPress vars and included files. */
require_once ABSPATH . 'wp-settings.php';
?>
```

1. Generating the Authentication Keys and Salts for wp-config.php
The values for AUTH_KEY, SECURE_AUTH_KEY, etc., are security keys and salts that WordPress uses for encrypting information stored in user cookies. You can generate new ones using the [WordPress Secret Key Generator](https://api.wordpress.org/secret-key/1.1/salt/). Simply visit that URL, and it will provide a unique set of values. Copy and paste these into your wp-config.php file where you see the keys and salts defined.


### --------------------------------------------
### Test wordpress -----------------------------

To test if your WordPress setup is working in Docker, you need to ensure that the WordPress container is up and accessible. Since Nginx and MariaDB are not yet configured, you can follow these steps to test WordPress in isolation:

Verify the Container is Running
Run the command below to check if the container is running as expected:

bash
Copy code
docker ps
Look for a container with the name or image name matching wordpress. If it's not running, you may need to troubleshoot the Dockerfile.

Check Container Logs
Inspect the WordPress container logs to see if there are any errors. Run:

bash
Copy code
docker logs wordpress
This can help you identify issues if the container starts but fails internally.

Set up Temporary PHP Server for WordPress Testing
Since you don't yet have Nginx configured, use PHP’s built-in server in the WordPress container to check if WordPress loads. First, connect to the container:

bash
Copy code
docker exec -it wordpress bash
Then navigate to the directory where WordPress is located (usually /var/www/html for Dockerized WordPress), and run the built-in PHP server:

bash
Copy code
php -S 0.0.0.0:8000
might to install:
Command 'php' not found, but can be installed with:
sudo apt install php8.3-cli  # version 8.3.6-0ubuntu0.24.04.2, or
sudo apt install php-cli     # version 2:8.2+93ubuntu1
sudo apt install php8.2-cli  # version 8.2.12-1ubuntu2

This will start a web server on port 8000 inside the container.

Access WordPress Locally
In your browser, navigate to http://localhost:8000. You should see the WordPress setup page if everything is working correctly within the container.

Next Steps
Once this is working, you can set up Nginx and MariaDB, reconfigure the WordPress container to connect to them, and test the complete setup.

Start PHP Built-in Server: If your Docker container is already set to start PHP-FPM, you might need to ensure that you also expose a port for the built-in server. Since you're using a Dockerfile with PHP-FPM, you might want to run PHP's built-in server as follows:

Option A: Modify Your Dockerfile to Run PHP Built-in Server
You can change your CMD in the Dockerfile or run the built-in server directly in the terminal after accessing your container. Here’s an example of how you might modify the last line in your Dockerfile to run the PHP server:

dockerfile
Copy code
CMD ["php", "-S", "0.0.0.0:8000", "-t", "/var/www/html/wordpress"]
This will start the PHP built-in server and serve files from the specified directory.

Option B: Running it in the Terminal
If you want to start the PHP built-in server manually, you can do the following:

bash
Copy code
docker exec -it your_wordpress_container_name bash
cd /var/www/html/wordpress
php -S 0.0.0.0:8000

Your setup is almost correct, but there are a few improvements and fixes needed. I’ll go over each file, pointing out issues and improvements.

1. Dockerfile for WordPress Container
Your Dockerfile is mostly correct but has a few points to check:

Directory Structure: Make sure the directory /var/www/html exists and has appropriate permissions. If it doesn’t, WordPress installation may fail.
Environment Variables in wp-config.php: Your wp-config.php relies on environment variables like ${WP_DATABASE_NAME}. But PHP won’t directly replace those. You may need to use a tool like envsubst or add commands in the script to replace placeholders.
Here’s an adjusted Dockerfile:

dockerfile
Copy code
# Use Debian as a base image (Debian 12)
FROM debian:bookworm

# Update & install packages
RUN apt-get -y update && \
    apt-get install -y php-fpm php-mysql curl mariadb-client

# Download WP-CLI
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp

# Create the directory where WordPress will be installed
RUN mkdir -p /var/www/html && chown -R www-data:www-data /var/www/html

# Copy the script and config
COPY ./tools/wp-script.sh /
COPY ./tools/wp-config.php /etc/wp-config.php

# Make sure the script is executable
RUN chmod +x /wp-script.sh

# Expose port 9000 for PHP-FPM
EXPOSE 9000

# Run PHP-FPM and the custom script
CMD ["/wp-script.sh"]
2. wp-script.sh Script
Your script seems to cover most requirements, but here are some improvements:

WordPress Path: Ensure the /var/www/html directory exists before running wp core download.
Configuration File Location: In the current setup, you’re using a custom wp-config.php that might not be correctly applied to /var/www/html/wp-config.php. Copy or symlink it to the correct location.
Database Variables: Confirm WP_DATABASE_NAME, DB_USER, DB_USER_PASSWORD, and WP_DATABASE_HOST are correctly sourced from .env.
Here’s an improved version of wp-script.sh:

bash
Copy code
#!/bin/bash

# Wait for MariaDB
echo "Waiting for the database to be ready..."
until mysqladmin ping -h "${WP_DATABASE_HOST}" --silent; do
    sleep 2
done

# Change to WordPress directory
cd /var/www/html

# Download WordPress if not already downloaded
if [ ! -f wp-login.php ]; then 
    echo "Downloading WordPress..."
    wp core download --allow-root
fi

# Copy the wp-config.php if it doesn't already exist
if [ ! -f wp-config.php ]; then
    echo "Copying wp-config.php..."
    cp /etc/wp-config.php wp-config.php
fi

# Install WordPress core
echo "Installing WordPress core..."
wp core install \
    --url="${DOMAIN_NAME}" \
    --title="inception" \
    --admin_user="${WP_ADMIN}" \
    --admin_password="${WP_ADMIN_PASSWORD}" \
    --admin_email="${WP_ADMIN_EMAIL}" \
    --allow-root

# Create additional WordPress user
echo "Creating WordPress user..."
wp user create "${WP_USER}" "${WP_USER_EMAIL}" --user_pass="${WP_USER_PASSWORD}" --allow-root

# Start PHP-FPM in the foreground
echo "Starting PHP-FPM in the foreground..."
exec php-fpm -F
3. wp-config.php (Configuration File)
In your wp-config.php, environment variables aren’t automatically replaced, and the syntax has some issues. PHP doesn’t process ${VAR_NAME} directly in strings. Instead, use getenv() or set environment variables using envsubst during setup.

Update wp-config.php as follows:

php
Copy code
<?php
// ** MySQL settings ** //
define('DB_NAME', getenv('WP_DATABASE_NAME'));
define('DB_USER', getenv('DB_USER'));
define('DB_USER_PASSWORD', getenv('DB_USER_PASSWORD'));
define('DB_HOST', getenv('WP_DATABASE_HOST'));
define('DB_CHARSET', 'utf8');
define('DB_COLLATE', '');

// ** Authentication Unique Keys and Salts **
define('AUTH_KEY',         '8EsCDOM}7G%]D<90c]-+TzD%w=_M0CoY1~$5id>.JPO({DW~i}0x!}Z5X2>H|dly');
define('SECURE_AUTH_KEY',  '|Ety5|C 8qA^t3>>kYI}6Zm)c%&HjVK[|qd(C;GGp?9kb;)2#-J[KUH-_g4aAl;=');
define('LOGGED_IN_KEY',    '7wEU[#J(-u27qaPl+a.)OdLv(.3U_m<SKMVvn90Ia)Mwd)|1j3P5{dVWk-6%:E6<');
define('NONCE_KEY',        '?DCZ?J_lRJq0[j@xhO8bQ<|Is<0L&WOncGPL<8L$-hkI,`^?Xk=;~5t~wy%z2*}+');
define('AUTH_SALT',        '/5iNnxCVI,Mwk-@@+i!aVmo~*])8l-Zeitu0+^ip lvp088s^3J[%|-#|R)-<wi$');
define('SECURE_AUTH_SALT', '&X>]HbfAq.^JtJ=20N+Q}od-[Z:szi<(4;fs/A$sFCR(}^WLNPH=2,+k80-bLqyT');
define('LOGGED_IN_SALT',   'zC{Fhx#4L5GxU5)Tu4$4>iiV.V}.|}  %lVL&V*?DB}!pIm(6(QFe^|sS#>$U<{8');
define('NONCE_SALT',       'ao;c@w@)!D@ujk+]D7O2 ?@T8b)il~LRzM|:ac`ykb;K;+.8/Yo4tf]X|R~+t+*5');

// Absolute path to the WordPress directory.
if ( ! defined( 'ABSPATH' ) ) {
    define( 'ABSPATH', '/var/www/html' );
}

// Sets up WordPress vars and included files.
require_once ABSPATH . 'wp-settings.php';
4. Additional Tips
Permissions: Ensure /var/www/html is writable by www-data user.
Database Connectivity: Ensure MariaDB is accessible using the host specified in WP_DATABASE_HOST. If the WordPress container can't reach the database, it might be due to networking issues or the wrong hostname.
Logs: Use docker-compose logs wordpress to identify specific errors.
After making these changes, restart your containers:

bash
Copy code
docker-compose down
docker-compose up -d
Then, monitor the logs with:

bash
Copy code
docker-compose logs -f wordpress
This should help resolve most issues and get your WordPress container working correctly.


docker exec -it mariadb mysql -ubob -p
MariaDB [(none)]> SHOW DATABASES;
+--------------------+
| Database           |
+--------------------+
| WordPressDB        |
| information_schema |
+--------------------+
2 rows in set (0.000 sec)

shouldn't mariadb be in there aswell?

ChatGPT said:
ChatGPT
The absence of a database explicitly named mariadb in the SHOW DATABASES output is not an issue unless you expect such a database to exist for your setup. Let me clarify:

Explanation:
Default and User-Created Databases:

The SHOW DATABASES; command lists all databases currently accessible to the logged-in user.
By default, MariaDB does not create a database named mariadb. It typically includes:
information_schema: A system database for metadata.
User-created databases (e.g., WordPressDB in your case).
Your Database WordPressDB:

If WordPressDB is intended to be the database used by WordPress, this is correct and expected.
MariaDB itself does not have a "self-referencing" database; its functionality is tied to these databases and the system metadata.










Confirm both wordpress and mariadb are connected to the same network.
How do I check that?
$ docker network inspect inception_net
[
    {
        "Name": "inception_net",
        "Id": "ab3dfa78b2597856d4f70933ba09f396e15c031eb425704db08e12696f983d12",
        "Created": "2024-11-17T16:05:22.508771843+01:00",
        "Scope": "local",
        "Driver": "bridge",
        "EnableIPv6": false,
        "IPAM": {
            "Driver": "default",
            "Options": null,
            "Config": [
                {
                    "Subnet": "172.18.0.0/16",
                    "Gateway": "172.18.0.1"
                }
            ]
        },
        "Internal": false,
        "Attachable": false,
        "Ingress": false,
        "ConfigFrom": {
            "Network": ""
        },
        "ConfigOnly": false,
        "Containers": {
            "385d8e8062ac3a1796d13e065be4ad16dcae998e3851282d926c03aea7150065": {
                "Name": "wordpress",
                "EndpointID": "e5fc211c722176da66b72690a3e6f2f793318d2808fb6c798704897d9dbf1a29",
                "MacAddress": "02:42:ac:12:00:03",
                "IPv4Address": "172.18.0.3/16",
                "IPv6Address": ""
            },
            "80435b2bd6ec91a3f486364c9d335ebd1ddc7d0d86039383d7ce443062c016d7": {
                "Name": "nginx",
                "EndpointID": "3dd49a7cc5ca091438ea5dbb09bd04da2de06df3081782d19916a15beb479d69",
                "MacAddress": "02:42:ac:12:00:04",
                "IPv4Address": "172.18.0.4/16",
                "IPv6Address": ""
            },
            "bb75159fafac513d9d9391ff7cb5faaedb89d7557671e0e45f84f76004528d16": {
                "Name": "mariadb",
                "EndpointID": "47a603a457836784d4817c5818b227b22c524208c5293be5cb31cd646e671e1c",
                "MacAddress": "02:42:ac:12:00:02",
                "IPv4Address": "172.18.0.2/16",
                "IPv6Address": ""
            }
        },
        "Options": {},
        "Labels": {
            "com.docker.compose.network": "inception",
            "com.docker.compose.project": "srcs",
            "com.docker.compose.version": "2.29.7"
        }
    }
]
ChatGPT said:
ChatGPT
From the output of docker network inspect inception_net, we can confirm that both the wordpress and mariadb containers are connected to the same network (inception_net). Here's the relevant part of the output:

Key Details from the Network Inspection
Network Name: inception_net
Containers Connected:
wordpress:
IPv4 Address: 172.18.0.3
mariadb:
IPv4 Address: 172.18.0.2
nginx:
IPv4 Address: 172.18.0.4
Confirmation
Both wordpress and mariadb are listed under Containers in the inception_net network.
The IPv4Address assignments confirm that they are reachable on this network (172.18.0.x).





docker exec -it wordpress bash
Edit the /etc/hosts file: Open /etc/hosts with a text editor (e.g., nano or vi):

bash
Copy code
nano /etc/hosts
Add the mariadb entry: Add the following line to /etc/hosts:

Copy code
172.18.0.2    mariadb
Save and exit the editor:

For nano, press CTRL + X, then press Y to confirm, and Enter to save.
Test connectivity: Now try pinging mariadb again from within the WordPress container:

bash
Copy code
ping mariadb










Yes, it looks like the ping command is also not available in your WordPress container by default. This is because many Docker images, especially minimal ones like the official WordPress image, come with a stripped-down set of utilities, and ping may not be included.

To install ping in the WordPress container:
Access the WordPress container: First, open a shell inside your WordPress container:

bash
Copy code
docker exec -it wordpress bash
Install iputils-ping: In many Linux distributions (including Debian/Ubuntu, which is what the WordPress Docker image is based on), the ping utility is provided by the iputils-ping package. To install it, run the following command inside the container:

bash
Copy code
apt-get update && apt-get install -y iputils-ping
Test the ping command: After installation, you should be able to ping the mariadb container:

bash
Copy code
ping mariadb
If ping works after this, it means the network connectivity issue between the WordPress and MariaDB containers has been resolved.

Alternative: Use nc (Netcat)
If you're unable or prefer not to install ping, you can also use nc (Netcat) to check if the MariaDB container is accessible from the WordPress container:

Install netcat (if necessary): If the nc command is not available, you can install it with:

bash
Copy code
apt-get update && apt-get install -y netcat
Test the connection: Once nc is installed, test the connection to the MariaDB container on port 3306:

bash
Copy code
nc -zv mariadb 3306
This will try to connect to mariadb on port 3306 (the default MySQL/MariaDB port), and it will show whether the connection is successful.

GRANT ALL PRIVILEGES ON *.* TO 'root'@'wordpress.inception_net' IDENTIFIED BY 'root' WITH GRANT OPTION;
FLUSH PRIVILEGES;








docker inspect wordpress




docker exec -it wordpress bash
mysql -h mariadb -u bob -pbob




Verify environment variable substitution in wp-config.php:

Environment variables like ${WP_DATABASE_HOST} may not be substituted correctly in your wp-config.php.
Update the script to replace placeholders directly:
bash
Copy code
sed -i "s/\${WP_DATABASE_NAME}/${WP_DATABASE_NAME}/g" /var/www/html/wordpress/wp-config.php
sed -i "s/\${DB_USER}/${DB_USER}/g" /var/www/html/wordpress/wp-config.php
sed -i "s/\${DB_USER_PASSWORD}/${DB_USER_PASSWORD}/g" /var/www/html/wordpress/wp-config.php
sed -i "s/\${WP_DATABASE_HOST}/${WP_DATABASE_HOST}/g" /var/www/html/wordpress/wp-config.php




RUN sed -i "s|\${WP_DATABASE_NAME}|wordpress|g" /etc/wp-config.php && \
    sed -i "s|\${DB_USER}|bob|g" /etc/wp-config.php && \
    sed -i "s|\${DB_USER_PASSWORD}|bob|g" /etc/wp-config.php && \
    sed -i "s|\${WP_DATABASE_HOST}|mariadb|g" /etc/wp-config.php





Testing the Fixes
Rebuild and restart the containers:

bash
Copy code
docker-compose down
docker-compose build
docker-compose up -d
Monitor logs:

bash
Copy code
docker logs wordpress -f
Verify functionality by accessing WordPress in your browser:

bash
Copy code
https://<DOMAIN_NAME>
Let me know if you encounter further issues!






4. Test Database Connection from WordPress Container
From the wordpress container, test connectivity to MariaDB:

bash
Copy code
docker exec -it wordpress mysql -u bob -pbob -h mariadb -e "SHOW DATABASES;"
Expected output:

text
Copy code
+--------------------+
| Database           |
+--------------------+
| information_schema |
| mysql              |
| performance_schema |
| sys                |
| wordpress          |
+--------------------+
If this works, the database connection is functional.


---



ocker exec -it wordpress wp --info



docker exec -it wordpress ls -l /var/www/html/wordpress
"
:/mnt/shared/srcs$ docker exec -it wordpress ls -l /var/www/html/wordpress
total 240
-rw-r--r--  1 root     root       405 Nov 24 17:17 index.php
-rw-r--r--  1 root     root     19915 Nov 24 17:17 license.txt
-rw-r--r--  1 root     root      7409 Nov 24 17:17 readme.html
-rw-r--r--  1 root     root      7387 Nov 24 17:17 wp-activate.php
drwxr-xr-x  9 root     root      4096 Nov 24 17:17 wp-admin
-rw-r--r--  1 root     root       351 Nov 24 17:17 wp-blog-header.php
-rw-r--r--  1 root     root      2323 Nov 24 17:17 wp-comments-post.php
-rw-r--r--  1 root     root      3336 Nov 24 17:17 wp-config-sample.php
-rwxrwx---  1 www-data www-data  1752 Nov 22 17:09 wp-config.php
drwxr-xr-x  4 root     root      4096 Nov 24 17:17 wp-content
-rw-r--r--  1 root     root      5617 Nov 24 17:17 wp-cron.php
drwxr-xr-x 30 root     root     16384 Nov 24 17:17 wp-includes
-rw-r--r--  1 root     root      2502 Nov 24 17:17 wp-links-opml.php
-rw-r--r--  1 root     root      3937 Nov 24 17:17 wp-load.php
-rw-r--r--  1 root     root     51367 Nov 24 17:17 wp-login.php
-rw-r--r--  1 root     root      8543 Nov 24 17:17 wp-mail.php
-rw-r--r--  1 root     root     29032 Nov 24 17:17 wp-settings.php
-rw-r--r--  1 root     root     34385 Nov 24 17:17 wp-signup.php
-rw-r--r--  1 root     root      5102 Nov 24 17:17 wp-trackback.php
-rw-r--r--  1 root     root      3246 Nov 24 17:17 xmlrpc.php
"




Example www.conf File
Here’s an example of a minimal www.conf file suitable for a WordPress container:

ini
Copy
Edit
[www]
user = www-data
group = www-data

listen = 9000                           ; PHP-FPM listens on port 9000

pm = dynamic                            ; Process management style
pm.max_children = 10                    ; Max number of child processes
pm.start_servers = 3                    ; Start this many processes on startup
pm.min_spare_servers = 2                ; Minimum spare workers
pm.max_spare_servers = 5                ; Maximum spare workers

; Logging settings
access.log = /var/log/php-fpm/access.log
error_log = /var/log/php-fpm/error.log
log_level = notice

; Security and permissions
listen.owner = www-data
listen.group = www-data
listen.mode = 0660
How to Use www.conf in Your WordPress Dockerfile
Locate or Create the File:

Use the default file from PHP-FPM or create a custom one like the example above.
Include It in the Docker Image:

Your Dockerfile copies the file:
dockerfile
Copy
Edit
COPY /tools/www.conf /etc/php/8.2/fpm/pool.d/
This ensures your custom settings are applied when the container runs.
Ensure PHP-FPM Uses It:

PHP-FPM automatically loads configuration files from /etc/php/8.2/fpm/pool.d/. No further action is needed unless you override this behavior.
What Happens If You Don’t Use www.conf?
Default Configuration:

PHP-FPM will use its default www.conf, which might not match your container’s needs (e.g., port 9000, resource limits).
Incompatibility with Your Setup:

If the default www.conf doesn’t listen on port 9000, your WordPress container won’t work as intended, and connections from NGINX or other services will fail.
Suboptimal Performance:

Without fine-tuning, PHP-FPM might underperform or waste resources in your environment.













WordPress:
Once MariaDB is up, start the WordPress container. During startup, WordPress will try to connect to the database, so having MariaDB ready beforehand is essential.
WordPress will connect to MariaDB using environment variables (like database host, username, and password) in your docker-compose.yml file or Docker run command.

-->

- Nginx

 <!-- 

# NGINX

###  Docker ----------------------------
This Dockerfile sets up a Docker image with NGINX installed on a Debian Linux (Debian 12 "Bookworm") base image, along with a self-signed SSL certificate for TLS encryption. Let’s break it down line by line:

1. FROM debian:bookworm
Specifies the base image for the Docker container. Here, it uses the Debian 12 ("Bookworm") version as the OS. This means the container will have a minimal Debian Linux environment to start with.
2. RUN apt-get update -y && apt-get upgrade -y && apt-get install -y nginx openssl -y
apt-get update -y updates the package lists to ensure the latest versions are available.
apt-get upgrade -y upgrades any outdated packages on the base image.
apt-get install -y nginx openssl installs NGINX (the web server) and OpenSSL (for creating SSL/TLS certificates) in one command. The -y flag automatically confirms the installation, so it runs without manual intervention.
3. RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout "/etc/ssl/private/nginx-selfsigned.key" -subj "/C=/ST=/L=/O=/CN=${DOMAIN_NAME}" -out /etc/ssl/certs/nginx-selfsigned.crt
This command creates a self-signed SSL certificate using OpenSSL for secure HTTPS connections.
-x509 specifies the certificate format (X.509 is the standard format for TLS certificates).
-nodes means no password protection on the private key, so NGINX can load it without user input.
-days 365 sets the certificate to be valid for 365 days.
-newkey rsa:2048 generates a new 2048-bit RSA key pair.
-keyout specifies where to save the private key.
-subj "/C=/ST=/L=/O=/CN=${DOMAIN_NAME}" generates a certificate with the subject fields, including the common name (CN) for the domain. The ${DOMAIN_NAME} variable is expected to be defined externally.
-out specifies where to save the public certificate.
4. COPY conf/default-nginx.conf /etc/nginx/conf.d/
Copies a custom NGINX configuration file (default-nginx.conf) from the Docker build context’s conf directory into the container at /etc/nginx/conf.d/. This configuration file customizes how NGINX will handle requests, routes, or server settings.
5. EXPOSE 443
Tells Docker to expose port 443 on the container for HTTPS traffic. However, this does not automatically publish the port to the host. You’ll need to publish this port explicitly when running the container (e.g., using -p 443:443).
6. CMD ["nginx", "-g", "daemon off;"]
Sets the command to run when the container starts. nginx is started with the flag -g "daemon off;" to prevent it from running as a background process. This keeps the container running and allows Docker to monitor the main process.



The difference between -keyout /etc/nginx/key.pem and -keyout "/etc/ssl/private/nginx-selfsigned.key" lies in the file paths and naming conventions used to store the private key. Let's break down what each part means and how these paths affect where the key is stored.

1. File Path Differences
-keyout /etc/nginx/key.pem

This specifies that the private key will be stored in the /etc/nginx/ directory with the filename key.pem.
The /etc/nginx/ directory typically holds NGINX configuration files and custom assets specific to NGINX, such as certificates or custom server settings. While storing the private key here works, it may not follow typical conventions and could expose the key to other users if permissions aren’t carefully set.
The .pem file extension is often used to denote cryptographic files that store keys or certificates in "Privacy-Enhanced Mail" (PEM) format, which is widely used for SSL certificates.
-keyout "/etc/ssl/private/nginx-selfsigned.key"

This path places the private key in /etc/ssl/private/, which is a standard location in Linux for storing private keys, with the filename nginx-selfsigned.key.
The /etc/ssl/ directory is typically used to store SSL certificates and private keys in subdirectories:
/etc/ssl/private/ is intended for private keys.
/etc/ssl/certs/ is generally used for public certificates.
This directory typically has restricted access for security, making it a more secure choice for storing private keys.
2. Security and Convention
Using /etc/ssl/private/ is generally more secure and follows Linux conventions, as it restricts access by default. This can reduce the risk of unintended access to sensitive files. The /etc/nginx/ directory does not have the same restrictive permissions by default, so storing keys here could be less secure unless permissions are manually adjusted.

3. File Naming Conventions
The file name itself, key.pem vs. nginx-selfsigned.key, is more about clarity than functionality.

key.pem is a more generic name and may be less clear in its purpose if you manage multiple keys.
nginx-selfsigned.key specifies that it’s a self-signed certificate generated for NGINX, which can help avoid confusion if multiple keys are present.
Summary
/etc/nginx/key.pem: Stores the private key in the NGINX directory, but it’s less secure and unconventional for storing SSL keys.
/etc/ssl/private/nginx-selfsigned.key: Stores the key in a secure, standard location, making it more secure and in line with common Linux SSL configurations.
For production environments, it's recommended to use /etc/ssl/private/ for storing private keys due to security best practices.
### --------------------------------------------

### Config.conf --------------------------------

Your NGINX configuration file is mostly correct, but there are a few improvements and potential corrections you may want to consider, especially for security and compatibility. Let's go through each section with comments on adjustments.

1. listen Directive for SSL
nginx
Copy code
listen 443 ssl;
listen [::]:443 ssl;
These lines look good and will bind both IPv4 and IPv6 addresses to port 443 for SSL.
2. server_name Directive
nginx
Copy code
server_name $DOMAIN_NAME www.$DOMAIN_NAME localhost;
This line sets the server name for your virtual host. Ensure that $DOMAIN_NAME is set correctly in the environment, or replace it with an actual domain name (e.g., example.com). Otherwise, NGINX might fail to parse the variable.
3. SSL Settings
nginx
Copy code
ssl on;
ssl_certificate /etc/ssl/certs/nginx-selfsigned.crt;
ssl_certificate_key /etc/ssl/private/nginx-selfsigned.key;
ssl_protocols TLSv1.2 TLSv1.3;
ssl on; is technically redundant and can be omitted. Including ssl in the listen directive (listen 443 ssl;) is sufficient to enable SSL.
Certificates: The paths are correct, assuming these files exist at the specified locations.
SSL Protocols: Specifying TLSv1.2 and TLSv1.3 is a good practice to support the most secure and compatible protocols. You may also want to add an ssl_ciphers directive to control which ciphers are allowed:
nginx
Copy code
ssl_ciphers HIGH:!aNULL:!MD5;
ssl_prefer_server_ciphers on;
4. File Handling
nginx
Copy code
root /var/www/html;
index index.html index.php;
try_files $uri $uri/ =404;
These settings look fine:
root sets the document root for the server.
index specifies default files when a directory is requested.
try_files $uri $uri/ =404; tries to load the file directly or look for a directory with the requested name; if neither exists, it returns a 404 error.
5. PHP Location Block
nginx
Copy code
location ~ \.php$ {
    fastcgi_pass wordpress:9000;
    fastcgi_index index.php;
    include fastcgi_params;
    fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
    fastcgi_param PATH_INFO $fastcgi_path_info;
}
fastcgi_pass wordpress:9000; assumes that there’s a FastCGI server (e.g., PHP-FPM) available at wordpress:9000.
Make sure the hostname wordpress resolves within your Docker network or adjust this to 127.0.0.1:9000 if running PHP-FPM locally in the container.
SCRIPT_FILENAME and PATH_INFO parameters look good.
include fastcgi_params;: Ensure that fastcgi_params exists in your configuration files (usually in /etc/nginx/), as it includes essential FastCGI parameters.
Final Suggested Config File
Here’s the configuration with the improvements and comments integrated:

nginx
Copy code
server {
    listen                  443 ssl;
    listen                  [::]:443 ssl;
    server_name             $DOMAIN_NAME www.$DOMAIN_NAME localhost;

    # SSL
    ssl_certificate         /etc/ssl/certs/nginx-selfsigned.crt;
    ssl_certificate_key     /etc/ssl/private/nginx-selfsigned.key;
    ssl_protocols           TLSv1.2 TLSv1.3;
    ssl_ciphers             HIGH:!aNULL:!MD5;
    ssl_prefer_server_ciphers on;

    # File Handling
    root                    /var/www/html;
    index                   index.html index.php;
    try_files               $uri $uri/ =404;

    # PHP Processing
    location ~ \.php$ {
        fastcgi_pass        wordpress:9000;  # Ensure the 'wordpress' hostname resolves correctly
        fastcgi_index       index.php;
        include             fastcgi_params;
        fastcgi_param       SCRIPT_FILENAME $document_root$fastcgi_script_name;
        fastcgi_param       PATH_INFO $fastcgi_path_info;
    }
}
This should be a solid configuration for your NGINX setup. Just ensure that:

$DOMAIN_NAME is properly defined.
The paths to fastcgi_params and SSL certificates are accurate.
The fastcgi_pass setting is correct based on your network setup.






Your NGINX container setup is mostly well done, but there are a few small issues that might prevent it from working as expected.

1. Dockerfile Issues
Self-Signed SSL Certificate Creation
Environment Variables in openssl: The openssl command in your Dockerfile uses ${DOMAIN_NAME}, but this value won't be expanded directly in the RUN command because Docker's build process does not inherit environment variables from the .env file.
Solution: You can hard-code the domain name or pass it as a build argument. Alternatively, you could create the certificate in the CMD or ENTRYPOINT script after the container has access to environment variables.
EXPOSE Command
You expose only port 443, which is correct for HTTPS. However, ensure that your docker-compose.yml file explicitly maps 443:443 under the NGINX service so it’s accessible outside the container.
Redundant -y in apt-get Commands
Minor but noticeable, there’s a redundant -y in the apt-get install line. It’s already covered, so you can remove one of them for clarity.
2. Nginx Configuration File (default-nginx.conf) Issues
Your NGINX configuration file is generally correct, but there are a few specific areas to address:

server_name Directive
$DOMAIN_NAME in the configuration file won’t resolve directly unless you’re passing it correctly via environment variables. If ${DOMAIN_NAME} is supposed to be set by Docker, you’ll need to ensure the container has access to this environment variable.
ssl Directive
The line ssl on; is outdated. NGINX doesn’t require this setting if listen ... ssl; is used. You can remove ssl on; since it’s not needed and may cause errors with newer NGINX versions.
fastcgi_pass Configuration
fastcgi_pass wordpress:9000; looks correct as long as your WordPress container is actually named wordpress in docker-compose.yml.
Ensure that your fastcgi_params file, usually located at /etc/nginx/fastcgi_params, is present and configured correctly.
Minor Syntax Clean-Up
Here is a cleaned-up version of your NGINX configuration:

nginx
Copy code
server {
    listen                  443 ssl;
    listen                  [::]:443 ssl;
    server_name             ${DOMAIN_NAME} www.${DOMAIN_NAME} localhost;
    
    # SSL Configuration
    ssl_certificate         /etc/ssl/certs/nginx-selfsigned.crt;
    ssl_certificate_key     /etc/ssl/private/nginx-selfsigned.key;
    ssl_protocols           TLSv1.2 TLSv1.3;

    # File Handling
    root                    /var/www/html;
    index                   index.html index.php;
    try_files               $uri $uri/ =404;

    location ~ \.php$ {
        fastcgi_pass        wordpress:9000;
        fastcgi_index       index.php;
        include             fastcgi_params;
        fastcgi_param       SCRIPT_FILENAME $document_root$fastcgi_script_name;
        fastcgi_param       PATH_INFO $fastcgi_path_info;
    }
}
3. Ensuring Compatibility in docker-compose.yml
Ensure that in your docker-compose.yml file:

The environment variable DOMAIN_NAME is accessible in the NGINX container if needed.
The NGINX service maps port 443:443 explicitly.
4. Testing and Debugging
After making these adjustments:

Rebuild and Restart: Rebuild the container and check logs to confirm there are no SSL or configuration errors.

bash
Copy code
docker-compose build
docker-compose up -d
Access Logs: Check NGINX logs to troubleshoot any runtime issues.

bash
Copy code
docker-compose logs nginx
Verify NGINX Access: Access the HTTPS URL and confirm SSL is working correctly.








I found this example:
dockerfile:
"
FROM debian:buster
RUN apt -y update && apt install -y nginx && apt install openssl -y
COPY ./tools/script.sh /
CMD [ "/script.sh" ]
"

script.sh:
"
#!/bin/bash
openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/nginx-selfsigned.key -out $CERTS_ -subj "/C=MO/L=KH/O=1337/OU=student/CN=sahafid.42.ma"
echo "
server {
    listen 443 ssl;
    listen [::]:443 ssl;
    #server_name www.$DOMAIN_NAME $DOMAIN_NAME;
    ssl_certificate $CERTS_;
    ssl_certificate_key /etc/ssl/private/nginx-selfsigned.key;" > /etc/nginx/sites-available/default
echo '
    ssl_protocols TLSv1.3;
    index index.php;
    root /var/www/html;
    location ~ [^/]\.php(/|$) { 
            try_files $uri =404;
            fastcgi_pass wordpress:9000;
            include fastcgi_params;
            fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
        }
} ' >>  /etc/nginx/sites-available/default
nginx -g "daemon off;"
"

config.conf:
"
server {
    listen 443 ssl;
    listen [::]:443 ssl;
    server_name www.sahafid.1337.ma sahafid.1337.ma;
    ssl_certificate here_certs;
    ssl_certificate_key /etc/ssl/private/nginx-selfsigned.key;
    ssl_protocols TLSv1.3;
    index index.php;
    root /var/www/html;
    location ~ [^/]\.php(/|$) { 
            try_files $uri =404;
            fastcgi_pass wordpress:9000;
            include fastcgi_params;
            fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
        }
}
"

can you explain what is happening in the script.sh and if the echo is necessary?


ChatGPT said:
ChatGPT
Certainly! Let’s break down the script.sh and evaluate its components and necessity.

Breakdown of script.sh
bash
Copy code
#!/bin/bash

# Generate a self-signed SSL certificate using OpenSSL
openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
  -keyout /etc/ssl/private/nginx-selfsigned.key \
  -out $CERTS_ \
  -subj "/C=MO/L=KH/O=1337/OU=student/CN=sahafid.42.ma"

# Create a server block configuration for Nginx (part 1)
echo "
server {
    listen 443 ssl;
    listen [::]:443 ssl;
    #server_name www.$DOMAIN_NAME $DOMAIN_NAME;
    ssl_certificate $CERTS_;
    ssl_certificate_key /etc/ssl/private/nginx-selfsigned.key;" > /etc/nginx/sites-available/default

# Add additional configuration details (part 2)
echo '
    ssl_protocols TLSv1.3;
    index index.php;
    root /var/www/html;
    location ~ [^/]\.php(/|$) { 
            try_files $uri =404;
            fastcgi_pass wordpress:9000;
            include fastcgi_params;
            fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
        }
} ' >>  /etc/nginx/sites-available/default

# Start Nginx in the foreground
nginx -g "daemon off;"
What It Does
Generate SSL Certificate with OpenSSL

bash
Copy code
openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/ssl/private/nginx-selfsigned.key \
    -out $CERTS_ \
    -subj "/C=MO/L=KH/O=1337/OU=student/CN=sahafid.42.ma"
Generates a self-signed SSL certificate for one year (-days 365).
Creates a private key (-keyout) and a certificate (-out).
-subj specifies the certificate details like country (C=MO), organization (O=1337), etc.
The $CERTS_ environment variable is used as the path to save the generated certificate.
Create the Nginx Configuration

Two echo commands are used to construct the /etc/nginx/sites-available/default file, which defines the server block for Nginx.

Part 1: Adds basic settings like listen directives and SSL certificate paths.

bash
Copy code
echo "
server {
    listen 443 ssl;
    listen [::]:443 ssl;
    #server_name www.$DOMAIN_NAME $DOMAIN_NAME;
    ssl_certificate $CERTS_;
    ssl_certificate_key /etc/ssl/private/nginx-selfsigned.key;" > /etc/nginx/sites-available/default
Part 2: Adds remaining server configurations for SSL protocols, PHP handling, and root directory.

bash
Copy code
echo '
    ssl_protocols TLSv1.3;
    index index.php;
    root /var/www/html;
    location ~ [^/]\.php(/|$) { 
            try_files $uri =404;
            fastcgi_pass wordpress:9000;
            include fastcgi_params;
            fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
        }
} ' >>  /etc/nginx/sites-available/default
Why the split into two echo commands? This is likely for readability or organizational purposes, but it’s not strictly necessary. The entire configuration could be written in a single echo block or copied as a pre-created file instead.

Run Nginx

bash
Copy code
nginx -g "daemon off;"
Starts the Nginx process in the foreground (daemon off) to prevent the container from exiting.
Is the echo Necessary?
No, the echo commands are not strictly necessary.

Instead of dynamically generating the Nginx configuration file using echo, you could:

Include a static configuration file (e.g., default) in the COPY step of the Dockerfile.
Copy the file directly to the appropriate location during the Docker build process:
dockerfile
Copy code
COPY config.conf /etc/nginx/sites-available/default
This approach simplifies script.sh and avoids runtime generation of the configuration file.
Why Use echo?
The use of echo provides flexibility, allowing:

Dynamic configuration based on environment variables ($CERTS_, $DOMAIN_NAME).
The script to adapt the configuration without modifying or including additional files.
Recommendations:
If configuration values like $CERTS_ or $DOMAIN_NAME change often, keep the echo logic.
If they are static, use pre-built configuration files for simplicity and better maintainability.
Let me know if you'd like a streamlined example or further clarification!






You said:
would my way work aswell, because I can't have the 'RUN openssl reg ...' in the dockerfile, because of '-subj "/C=/ST=/L=/O=/CN=${DOMAIN_NAME}"'. The '${DOMAIN_NAME}' is not possible.
So I did it like this:
Dockerfile:
"
# Use Debian as a base image (Debian 12)
FROM debian:bookworm
# Update & intstall your package manager
RUN apt-get update -y && \
    apt-get upgrade -y && \
    apt-get install -y nginx openssl -y

# # Create a self-signed SSL certificate for TLS (or use your own cert files)
# RUN openssl req \
# 	-x509 \
# 	-nodes \
# 	-days 365 \ 
# 	-newkey rsa:2048 \
# 	-keyout "/etc/ssl/private/nginx-selfsigned.key" \
# 	-subj "/C=/ST=/L=/O=/CN=${DOMAIN_NAME}" \
# 	-out "/etc/ssl/certs/nginx-selfsigned.crt"

# Copy custom MariaDB configuration script from the 'tools' directory to the container’s root directory
COPY ./tools/nginx-config.conf /etc/nginx/conf.d/
COPY ./tools/nginx-script.sh /

# Expose NGINX port for HTTPS
EXPOSE 443

# Start NGINX in the foreground
# CMD ["nginx", "-g", "daemon off;"]
CMD [ "/script.sh" ]
"

script.sh:
"
#!/bin/bash

# Create a self-signed SSL certificate for TLS (or use your own cert files)
openssl req \
	-x509 \
	-nodes \
	-days 365 \ 
	-newkey rsa:2048 \
	-keyout "/etc/ssl/private/nginx-selfsigned.key" \
	-subj "/C=/ST=/L=/O=/CN=${DOMAIN_NAME}" \
	-out "/etc/ssl/certs/nginx-selfsigned.crt"

# Start NGINX in the foreground
nginx -g "daemon off;"
"


config.conf:
"
server {
	# Directives
	listen                  443 ssl;
	listen                  [::]:443 ssl;
	server_name             $DOMAIN_NAME www.$DOMAIN_NAME localhost;
	
	# SSL
	# ssl                     on;
	ssl_certificate         /etc/ssl/certs/nginx-selfsigned.crt;
	ssl_certificate_key     /etc/ssl/private/nginx-selfsigned.key;
	ssl_protocols           TLSv1.2 TLSv1.3;

	# File Handling
	root                    /var/www/html;
	index                   index.html index.php;
	try_files               $uri $uri/ =404;

	location ~ \.php$ {
        fastcgi_pass        WordPress:9000;
        fastcgi_index       index.php;
        include             fastcgi_params;
        fastcgi_param       SCRIPT_FILENAME $document_root$fastcgi_script_name;
        fastcgi_param       PATH_INFO $fastcgi_path_info;
		
	}
}

"

Is this way correct and will it work?
ChatGPT said:
ChatGPT
Yes, your approach is correct and should work, assuming everything is configured properly. By moving the OpenSSL certificate generation to script.sh and using environment variables (${DOMAIN_NAME}) at runtime, you achieve flexibility without breaking the Dockerfile's build process.

Here’s a detailed analysis of your setup:

Dockerfile
Your Dockerfile:

Installs the required packages (nginx and openssl) during the build process.
Copies the configuration and the script into the container.
Defers dynamic actions (like using ${DOMAIN_NAME}) to the runtime script, avoiding issues with unavailable variables during the build.
Strengths:

The Docker image build remains static and environment-agnostic, which is a best practice.
By deferring dynamic actions to the container's runtime (script.sh), the image can adapt to different environments.
Key Points:

Why RUN openssl fails: Environment variables like ${DOMAIN_NAME} are not resolved at build time because they are injected at runtime. Moving this to script.sh ensures the variables are available when the container runs.
The EXPOSE instruction is correct for making port 443 accessible.
script.sh
Your script.sh dynamically generates the SSL certificate using the runtime environment variable ${DOMAIN_NAME} and starts Nginx.

Breakdown:
bash
Copy code
openssl req \
    -x509 \
    -nodes \
    -days 365 \
    -newkey rsa:2048 \
    -keyout "/etc/ssl/private/nginx-selfsigned.key" \
    -subj "/C=/ST=/L=/O=/CN=${DOMAIN_NAME}" \
    -out "/etc/ssl/certs/nginx-selfsigned.crt"
Creates the self-signed SSL certificate with details populated from the ${DOMAIN_NAME} variable.
The /C=/ST=/L=/O=/CN=${DOMAIN_NAME} allows for flexibility in defining the certificate's common name (CN) dynamically.
bash
Copy code
nginx -g "daemon off;"
Starts Nginx in the foreground, keeping the container running.
config.conf
This file is a configuration for Nginx that defines the server behavior.

Key Features:
SSL Configuration:

Points to the dynamically generated certificate (/etc/ssl/certs/nginx-selfsigned.crt) and private key (/etc/ssl/private/nginx-selfsigned.key).
Enables TLS 1.2 and 1.3.
Dynamic Domain Support:

nginx
Copy code
server_name $DOMAIN_NAME www.$DOMAIN_NAME localhost;
Allows the server_name directive to adapt based on the runtime environment variable ${DOMAIN_NAME}.
PHP Handling:

nginx
Copy code
location ~ \.php$ {
    fastcgi_pass WordPress:9000;
    ...
}
Configures Nginx to forward PHP requests to a FastCGI process running on the container WordPress at port 9000.
Root and Index Directives:

nginx
Copy code
root /var/www/html;
index index.html index.php;
Specifies the document root and default index files.
Will This Work?
Yes, your setup is well-structured and should work if:

Environment Variables:

Ensure ${DOMAIN_NAME} is properly set when running the container (e.g., via docker run -e DOMAIN_NAME=example.com).
Container Network:

Ensure Nginx can communicate with the PHP service (WordPress:9000) as specified in fastcgi_pass. This requires a properly configured Docker network if these are in separate containers.
Configuration File Location:

Ensure Nginx loads your custom configuration file (/etc/nginx/conf.d/nginx-config.conf). By default, Nginx includes configurations from /etc/nginx/conf.d/*.conf.
File Permissions:

Verify permissions for generated SSL certificates and configuration files.
Suggested Improvements:
Validate Environment Variable: Add a check in script.sh to ensure ${DOMAIN_NAME} is not empty:

bash
Copy code
if [ -z "${DOMAIN_NAME}" ]; then
    echo "DOMAIN_NAME is not set. Exiting."
    exit 1
fi
Default Configuration: Consider a fallback for server_name if ${DOMAIN_NAME} is missing:

nginx
Copy code
server_name $DOMAIN_NAME www.$DOMAIN_NAME localhost;
Simplify Dockerfile Comments: Remove commented-out code (RUN openssl ...) to avoid confusion.

Conclusion
Your approach is correct and follows best practices for dynamic configuration in Docker. The setup should work as expected, provided you address the runtime dependencies like environment variables and network connectivity. Let me know if you'd like further clarification or assistance with testing!





These warnings are caused by missing values for several subject attributes in the openssl req command used to generate the SSL certificate.

C= stands for Country Name.
ST= stands for State or Province.
L= stands for Locality (City).
O= stands for Organization.
Since you haven’t specified these fields, OpenSSL is skipping them. The command still generates the certificate, but these attributes are left empty.

This is usually not an issue if you're creating a self-signed certificate for local or testing purposes (like in your case with nginx), but for production, it’s a good practice to fill out those values to avoid warnings or errors from browsers when using the certificate.





4. Test the Server Configuration with NGINX:
You can also test the NGINX configuration for errors before trying to start the server by running this command inside the container:

bash
Copy code
docker exec -it <nginx-container-name> nginx -t
If everything is configured correctly, you should see a message like:

vbnet
Copy code
nginx: the configuration file /etc/nginx/nginx.conf syntax is ok
nginx: configuration file /etc/nginx/nginx.conf test is successful
If there are errors, NGINX will output them, and you can fix the issues based on the error messages.




docker network ls
docker network inspect bridge




SSL Certificate Creation Logs:

objectivec
Copy code
Create a self-signed SSL certificate...
.+...+.+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*...........+...
This part is generated by the openssl req command, which is used to generate a self-signed SSL certificate. The characters you're seeing like +, *, and . represent the progress of the SSL certificate generation process, which is normal output for OpenSSL commands. These are just indicators of the internal progress, but they don't affect the result of the SSL certificate creation.



Accessing NGINX: Ensure that NGINX is running properly by accessing it through the browser at https://<your_domain_or_ip>. You should see your website served over HTTPS.
Certificate in Use: If you're using a self-signed certificate, browsers might show a warning saying the connection is not trusted. For a production environment, you'd want to use a certificate from a trusted certificate authority (CA).





s$ curl -k https://jmetzger.42.fr
curl: (6) Could not resolve host: jmetzger.42.fr
jmetzger@jmetzger-VirtualBox:/mnt/shared/42Project-Inception-main/srcs$ openssl s_client -connect jmetzger.42.fr:443
40178B4D30700000:error:10080002:BIO routines:BIO_lookup_ex:system lib:../crypto/bio/bio_addr.c:738:Name or service not known
connect:errno=22
jmetzger@jmetzger-VirtualBox:/mnt/shared/42Project-Inception-main/srcs$ nslookup jmetzger.42.fr
Server:         127.0.0.53
Address:        127.0.0.53#53

** server can't find jmetzger.42.fr: NXDOMAIN





$ sudo netstat -tuln | grep 443
sudo: netstat: command not found
jmetzger@jmetzger-VirtualBox:/mnt/shared/42Project-Inception-main/srcs$ sudo apt install net-tools





port forwarding for a Virtual Machine (VM) running on software like VirtualBox or VMware, where you want to make services (like NGINX) inside the VM accessible from your host machine or external network. Let me break it down and explain whether or not you need to perform this setup.
Do You Need Port Forwarding?
Step 1: Determine Your Virtualization Platform
The steps depend on whether you're using VirtualBox, VMware, Hyper-V, or another virtualization software.
For VirtualBox:
Open VirtualBox Manager.
Select your VM.
Click on Settings > Network:
Ensure the network adapter is set to NAT or Bridged Adapter.
If the adapter is NAT, click Advanced > Port Forwarding:
Add rules for ports 80 and 443:
Rule 1:
Name: HTTP
Protocol: TCP
Host Port: 80
Guest Port: 80
Rule 2:
Name: HTTPS
Protocol: TCP
Host Port: 443
Guest Port: 443
Click OK to save and restart your VM














Problem1:
path '/etc/ssl/private/nginx-selfsigned.key' has permission denied
and path '/etc/ssl/certs/nginx-selfsigned.crt', has nginx-selfsigned.crt not such a file or directory. 

Could it be that they are installed somewhere else or that I need to set the permission or do I need to create folders?



ChatGPT said:
ChatGPT

It looks like you're running into permission and directory issues for the SSL certificate files (nginx-selfsigned.key and nginx-selfsigned.crt). Let's address both problems:
Problem 1: Permission Denied for /etc/ssl/private/nginx-selfsigned.key

This error indicates that NGINX does not have the necessary permissions to write to the /etc/ssl/private/ directory, or it doesn’t exist. You need to ensure the directory is created and has the correct permissions for NGINX to write the key.
Problem 2: File or Directory Not Found for /etc/ssl/certs/nginx-selfsigned.crt

This error indicates that either the /etc/ssl/certs/ directory does not exist, or the file was not created successfully during the script execution.
Steps to Resolve These Issues:
1. Ensure Directories Exist

You need to create the necessary directories for storing the SSL certificate files. You can add these commands in your nginx-script.sh to ensure that the directories exist before attempting to write the files:

Modify your nginx-script.sh to include the following directory creation steps:

#!/bin/bash

# Ensure ${DOMAIN_NAME} is not empty.
if [ -z "${DOMAIN_NAME}" ]; then
    echo "DOMAIN_NAME is not set. Exiting."
    exit 1
fi

# Ensure the necessary directories exist
mkdir -p /etc/ssl/private /etc/ssl/certs

# Create a self-signed SSL certificate for TLS (or use your own cert files)
echo "Creating a self-signed SSL certificate..."
openssl req \
    -x509 \
    -nodes \
    -days 365 \
    -newkey rsa:2048 \
    -keyout "/etc/ssl/private/nginx-selfsigned.key" \
    -subj "/C=NL/ST=Holland/L=Amsterdam/O=Codam/CN=${DOMAIN_NAME}" \
    -out "/etc/ssl/certs/nginx-selfsigned.crt"

# Check if the certificate files were created successfully
if [ ! -f /etc/ssl/certs/nginx-selfsigned.crt ] || [ ! -f /etc/ssl/private/nginx-selfsigned.key ]; then
    echo "Error: SSL certificate creation failed. Exiting."
    exit 1
else
    echo "SSL certificate creation successful."
fi

# Start NGINX in the foreground
echo "Starting nginx..."
nginx -g "daemon off;"

Explanation:

    mkdir -p /etc/ssl/private /etc/ssl/certs: This ensures that the directories /etc/ssl/private/ and /etc/ssl/certs/ exist. The -p flag will not give an error if the directories already exist.
    After ensuring the directories exist, the script proceeds to generate the SSL certificates.

2. Set Correct Permissions

The permission issue for /etc/ssl/private/nginx-selfsigned.key usually happens because the directory and/or files may not have the correct ownership or read/write permissions for the NGINX process (which often runs as www-data or nginx user). You can modify the script to set the correct permissions after creating the certificate files:

Modify your nginx-script.sh to set the correct file permissions:

#!/bin/bash

# Ensure ${DOMAIN_NAME} is not empty.
if [ -z "${DOMAIN_NAME}" ]; then
    echo "DOMAIN_NAME is not set. Exiting."
    exit 1
fi

# Ensure the necessary directories exist
mkdir -p /etc/ssl/private /etc/ssl/certs

# Create a self-signed SSL certificate for TLS (or use your own cert files)
echo "Creating a self-signed SSL certificate..."
openssl req \
    -x509 \
    -nodes \
    -days 365 \
    -newkey rsa:2048 \
    -keyout "/etc/ssl/private/nginx-selfsigned.key" \
    -subj "/C=NL/ST=Holland/L=Amsterdam/O=Codam/CN=${DOMAIN_NAME}" \
    -out "/etc/ssl/certs/nginx-selfsigned.crt"

# Check if the certificate files were created successfully
if [ ! -f /etc/ssl/certs/nginx-selfsigned.crt ] || [ ! -f /etc/ssl/private/nginx-selfsigned.key ]; then
    echo "Error: SSL certificate creation failed. Exiting."
    exit 1
else
    echo "SSL certificate creation successful."
fi

# Set correct permissions for the certificate files
chmod 600 /etc/ssl/private/nginx-selfsigned.key
chmod 644 /etc/ssl/certs/nginx-selfsigned.crt
chown root:root /etc/ssl/private/nginx-selfsigned.key
chown root:root /etc/ssl/certs/nginx-selfsigned.crt

# Start NGINX in the foreground
echo "Starting nginx..."
nginx -g "daemon off;"

Explanation:

    chmod 600 /etc/ssl/private/nginx-selfsigned.key: This command ensures that the private key file has read and write permissions only for the owner (root).
    chmod 644 /etc/ssl/certs/nginx-selfsigned.crt: This command ensures that the certificate file is readable by everyone, but only writable by the owner (root).
    chown root:root /etc/ssl/private/nginx-selfsigned.key and chown root:root /etc/ssl/certs/nginx-selfsigned.crt: This ensures the certificate files are owned by root, which is usually the appropriate user for NGINX to have access to these files.

3. Check If Files Exist After Running the Script

If the certificate files are still not being created, you can check manually whether the directories /etc/ssl/private/ and /etc/ssl/certs/ are created and the certificates are present:

docker exec -it <nginx-container-name> ls /etc/ssl/private
docker exec -it <nginx-container-name> ls /etc/ssl/certs

If the files are not found, it indicates that the script is not executing properly or that the directories are not created.
4. Ensure NGINX Can Read the Files

Finally, make sure that your NGINX configuration file is pointing to the correct paths for the certificate files, and that they are correctly mounted in the container (if using volumes).

For example, in the Docker Compose file (if you're using one), ensure the SSL certificates are correctly mapped:

services:
  nginx:
    image: nginx
    volumes:
      - ./nginx.conf:/etc/nginx/nginx.conf
      - ./ssl:/etc/ssl  # This maps the host ssl directory to the container

Alternatively, you can mount the specific certificate files from your host machine if you are not generating them dynamically inside the container.
Conclusion:

    Ensure the directories /etc/ssl/private/ and /etc/ssl/certs/ exist in your container and create them if they do not.
    Set the appropriate file permissions on the certificate files after they are created.
    Check if the files are being created successfully and ensure NGINX has access to them.
    Consider checking your Docker Compose or volume mounts to verify correct file paths.

By following these steps, you should be able to resolve both the permission and missing file issues.
You said:
problem 2:
what is happening in this line "# Replace domain in nginx config using envsubst
echo "Substituting DOMAIN_NAME in NGINX configuration..."
envsubst '${DOMAIN_NAME}' < /etc/nginx/conf.d/default.conf.template > /etc/nginx/conf.d/default.conf"
why do I need this?
ChatGPT said:
ChatGPT

The line you're referring to:

# Replace domain in nginx config using envsubst
echo "Substituting DOMAIN_NAME in NGINX configuration..."
envsubst '${DOMAIN_NAME}' < /etc/nginx/conf.d/default.conf.template > /etc/nginx/conf.d/default.conf

is part of a process to dynamically replace the ${DOMAIN_NAME} placeholder in your NGINX configuration file with the actual value of the DOMAIN_NAME environment variable. Let me explain why this step is needed and how it works.
What is envsubst and Why is It Needed?

    envsubst: This is a command-line utility that reads environment variables in a shell script or command and substitutes them into a file or string. It’s part of the GNU gettext suite of tools.

    Purpose: In your case, you have a variable ($DOMAIN_NAME) in your NGINX configuration (default.conf.template), but Docker doesn’t automatically substitute environment variables directly into your configuration files.

Thus, you need a way to replace the ${DOMAIN_NAME} placeholder with the actual domain name (the value of the DOMAIN_NAME environment variable) before starting NGINX.
Example:

Assume the following:

    You have an NGINX configuration file (default.conf.template) that contains a placeholder like this:

server {
    listen 443 ssl;
    server_name ${DOMAIN_NAME} www.${DOMAIN_NAME};
    ...
}

You have an environment variable DOMAIN_NAME set in your container, for example:

export DOMAIN_NAME="example.com"

The line you mentioned runs the envsubst command to replace ${DOMAIN_NAME} with the actual value of example.com.

    envsubst '${DOMAIN_NAME}' < /etc/nginx/conf.d/default.conf.template: This reads the default.conf.template file.
    > /etc/nginx/conf.d/default.conf: This writes the modified content to a new file (default.conf) with the domain name substituted in place of ${DOMAIN_NAME}.

After running the envsubst command, the resulting default.conf will look like this:

    server {
        listen 443 ssl;
        server_name example.com www.example.com;
        ...
    }

Why is This Necessary?

    Docker and Environment Variables: Docker doesn’t automatically substitute environment variables in files (e.g., nginx.conf or default.conf). It only uses environment variables in the shell environment or commands executed inside the container.

    Template Configuration: By using envsubst, you can have a template configuration file (default.conf.template) that contains placeholders for dynamic values like the domain name, which will be replaced at runtime when the container starts. This allows you to deploy the same container with different configurations based on the environment.

What Happens If You Skip This Step?

If you don’t use envsubst:

    The $DOMAIN_NAME in your NGINX configuration file will be treated as a literal string rather than the environment variable’s value.
    The NGINX server will not recognize the $DOMAIN_NAME as a valid domain and may not work as expected (i.e., it might not serve content properly because it doesn't match the actual domain).

Alternatives to envsubst:

If you prefer not to use envsubst, here are a couple of alternatives:

    Manually replace the domain in the NGINX config file before the container starts. This is more static, but less flexible.

    Use a Docker templating tool like dockerize, which can perform the substitution at runtime.

Summary:

    The envsubst command is used to substitute the value of an environment variable (in this case, DOMAIN_NAME) into a configuration file (default.conf.template) to dynamically configure NGINX based on the environment.
    It’s necessary because Docker doesn’t automatically replace environment variables inside configuration files.
    Without it, NGINX will not use the correct domain name, and your configuration might not work as expected.

You said:
I tried this step '5. Test NGINX with HTTP (Temporarily Disable SSL)'
I tried running this command 'curl -k https://jmetzger.42.fr', but I only got this output:
curl: (6) Could not resolve host: jmetzger.42.fr

Does that mean something is wrong with nginx? 
ChatGPT said:
ChatGPT

The error message curl: (6) Could not resolve host: jmetzger.42.fr indicates that DNS resolution is failing — meaning the domain name jmetzger.42.fr is not being resolved to an IP address. This is generally a network or DNS issue, rather than an issue with NGINX specifically. Let’s break it down and troubleshoot:
What Could Be Happening?

    DNS Resolution Issue:
        Your system is unable to resolve the domain name jmetzger.42.fr into an IP address.
        This could happen for a number of reasons, including misconfiguration of DNS settings or if the domain name hasn't been properly registered or linked to an IP address yet.

    NGINX Configuration Issue (unlikely based on this error):
        NGINX wouldn’t cause a DNS resolution failure. NGINX can only work with the IP address or hostname that it is given once DNS resolution is completed. If the DNS resolution fails, NGINX won’t even get a chance to respond.

Steps to Diagnose and Fix:

    Check DNS Resolution from Your Local Machine:

        Try to resolve the domain name manually using the dig or nslookup commands:

dig jmetzger.42.fr
# or
nslookup jmetzger.42.fr

If these commands don’t return an IP address, it means the domain is not resolving correctly, and the issue is likely with DNS configuration or propagation.

If the domain resolves correctly, you’ll see something like this:

    ;; ANSWER SECTION:
    jmetzger.42.fr.   3600    IN      A       192.0.2.123

Check DNS Settings:

    If the domain doesn't resolve, check your DNS settings. Make sure the domain jmetzger.42.fr has been registered and has the correct DNS records (especially the A record pointing to the correct server’s IP address).
    If you're using a custom DNS server, ensure it's working properly. If you don’t have control over the DNS (e.g., if it's managed by a third-party provider), you might need to verify the DNS records on their platform.

Try Using an IP Address Instead of Domain:

    If you know the server’s IP address where NGINX is running, try accessing it using the IP instead of the domain name:

    curl -k https://<server-ip>

    If this works, it further confirms that the issue is related to DNS resolution, not NGINX itself.

Check Docker Network Configuration:

    If you are running NGINX inside a Docker container, ensure that it is correctly connected to the Docker network and that other containers (e.g., the WordPress container) can communicate with each other.

    If you're accessing it via jmetzger.42.fr locally and it's supposed to be a local or development environment, make sure that the domain is properly mapped to the IP address of the NGINX container in your /etc/hosts file or via a local DNS setup (e.g., using a reverse proxy).

DNS Propagation Delay (if new domain):

    If you just registered or changed DNS settings for jmetzger.42.fr, it may take some time (typically up to 48 hours) for DNS changes to propagate globally. You can check the status of DNS propagation via online tools like DNS Checker.

Check Firewall and Ports:

    Make sure that the server where your NGINX is running is not blocking incoming traffic on port 443 (for HTTPS) or port 80 (for HTTP). This is especially relevant if you're trying to access your NGINX server externally.

NGINX Logs:

    Check your NGINX logs to see if there are any issues with how NGINX is handling requests:

        docker exec -it <nginx-container-name> tail -f /var/log/nginx/error.log

        This can give you more insight if NGINX is seeing incoming requests and if it’s handling them correctly.

Summary:

    The error Could not resolve host is related to DNS resolution, not necessarily an issue with NGINX.
    Check the DNS settings for jmetzger.42.fr and ensure the domain resolves correctly.
    Test with an IP address instead of the domain name to confirm that the server and NGINX are functioning correctly.
    If the domain is newly registered or DNS settings were just updated, consider the possibility of DNS propagation delay.

Once the DNS resolution issue is fixed, NGINX should be able to respond properly to requests.











$ curl -k https://jmetzger@127.0.0.1
<html>
<head><title>502 Bad Gateway</title></head>
<body>
<center><h1>502 Bad Gateway</h1></center>
<hr><center>nginx/1.22.1</center>
</body>
</html>
jmetzger@jmetzger-VirtualBox:/mnt/shared/42Project-Inception-main/srcs$ ls /etc/ssl/certs/nginx-selfsigned.crt
ls: cannot access '/etc/ssl/certs/nginx-selfsigned.crt': No such file or directory
jmetzger@jmetzger-VirtualBox:/mnt/shared/42Project-Inception-main/srcs$ ls /etc/ssl/private/nginx-selfsigned.key
ls: cannot access '/etc/ssl/private/nginx-selfsigned.key': Permission denied















So I added port 80 and 443.
Now command ' curl -k https://jmetzger@127.0.0.1' gives me this output:
"
<html>
<head><title>502 Bad Gateway</title></head>
<body>
<center><h1>502 Bad Gateway</h1></center>
<hr><center>nginx/1.22.1</center>
</body>
</html>
"
what does that mean? Does it mean my DOMAIN is not working correctly?
ChatGPT said:
ChatGPT

The 502 Bad Gateway error means that your NGINX server is unable to communicate properly with the upstream service, which in your case seems to be WordPress (running inside a Docker container or elsewhere). It indicates that NGINX is acting as a reverse proxy and is trying to forward requests to another server (like PHP or WordPress), but it can't connect successfully.
Common Causes for 502 Bad Gateway:

    PHP-FPM/WordPress Service is Down:
        If your NGINX configuration is trying to pass requests to PHP (through fastcgi_pass), but the PHP-FPM service (WordPress) is not running, you’ll get a 502 error.

    Incorrect FastCGI Configuration:
        If the fastcgi_pass in your NGINX configuration is pointing to the wrong address or port (e.g., the wrong IP address or container name for the WordPress service), NGINX will not be able to connect to the WordPress PHP service, resulting in a 502 error.

    Docker Networking Issues:
        If you're using Docker, the issue might be related to how the containers are networked. For instance, the NGINX container might not be able to communicate with the WordPress container if they're not connected to the same Docker network or if the service name used in fastcgi_pass is incorrect.

Troubleshooting Steps:

    Check WordPress/ PHP-FPM Container:
        Ensure that the WordPress container (or whatever service you're using for PHP-FPM) is running and healthy. You can check this with:

docker ps

Look for the container name or ID of the WordPress/PHP-FPM container. If it's not running, start it with:

    docker start <container-name>

Verify Container Networking:

    If you're using Docker Compose or standalone Docker containers, make sure that both the NGINX container and the WordPress container are on the same network. You can inspect the network configuration for the containers by running:

    docker network inspect <network-name>

    If you're using Docker Compose, ensure the containers are defined in the same docker-compose.yml file under the same networks section.

Check fastcgi_pass in NGINX Configuration:

    The NGINX configuration should be pointing to the correct location for PHP-FPM (the WordPress container). Check this line in your NGINX config:

    fastcgi_pass wordpress:9000;

    Here, wordpress should be the name of your WordPress container, and 9000 should be the PHP-FPM port. If you're using Docker, wordpress should match the service name in your docker-compose.yml or the container name.

Check PHP-FPM Logs:

    Check the logs of your WordPress (PHP-FPM) container to see if there are any errors preventing it from starting or responding correctly. Run:

    docker logs <wordpress-container-name>

    If there are issues with PHP-FPM, they should show up here.

Check NGINX Logs:

    Check the NGINX logs for more detailed error information. This will help you understand why the connection to the upstream service (WordPress) is failing.
        The error log is typically located at /var/log/nginx/error.log (inside the NGINX container or the host machine). You can view it by running:

        docker logs <nginx-container-name>

Confirm Ports and Networking:

    If you're using port forwarding (like 80:80 or 443:443), make sure that those ports are forwarded correctly from the host to the container.
    Additionally, verify that NGINX is listening on the correct IP address and port. You can check this with:

    curl -I http://127.0.0.1

Test Connection Between Containers:

    To ensure the NGINX container can reach the WordPress container, execute a simple test from the NGINX container (using docker exec):

        docker exec -it <nginx-container-name> ping wordpress

        This will help ensure that the NGINX container can reach the WordPress container by its name (or service name if using Docker Compose).

Conclusion:

The 502 Bad Gateway error likely means that NGINX is not able to connect to your upstream PHP-FPM/WordPress service. The problem could be due to:

    The WordPress/PHP-FPM container not running.
    Incorrect network configuration (containers not being able to talk to each other).
    A misconfiguration in your NGINX settings (wrong fastcgi_pass or incorrect container name/port).

By following the steps above, you can pinpoint the issue and fix the connectivity between NGINX and WordPress.





















Step 1: Verify Docker Compose Network
If you're using Docker Compose, containers must share the same network for hostnames (like mariadb) to resolve correctly.

List running containers:

bash
Copy code
docker ps
Check the container names and ensure both WordPress and MariaDB are running.

Inspect Docker networks:

bash
Copy code
docker network ls
Look for the network your containers should be part of (e.g., default or a custom network).

Inspect the network details:

bash
Copy code
docker network inspect <network-name>
Confirm both wordpress and mariadb are connected to the same network.

Step 2: Test Hostname Resolution
From the WordPress container, check if mariadb resolves to an IP address:

bash
Copy code
docker exec -it wordpress ping mariadb
Success: If you get responses, the containers are networked correctly.
Failure: The mariadb hostname is not resolving, likely due to:
Containers not on the same network.
Incorrect service name for MariaDB in WP_DATABASE_HOST.
Step 3: Manually Connect Using IP
If the hostname doesn’t resolve, try using MariaDB’s container IP address directly:

Get MariaDB’s IP address:

bash
Copy code
docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' mariadb
Example output: 172.18.0.2

Test connection using the IP:

bash
Copy code
mysql -h "172.18.0.2" -u "${DB_USER}" -p
If this works, the issue is with hostname resolution.

Step 4: Check Service Name
If using Docker Compose, the hostname should match the service name defined for MariaDB in the docker-compose.yml file.

Example:

yaml
Copy code
services:
  wordpress:
    ...
    environment:
      WP_DATABASE_HOST: mariadb

  mariadb:
    ...
    container_name: mariadb
Ensure the environment variable WP_DATABASE_HOST in WordPress matches the service name mariadb.
Step 5: Test MariaDB from Its Container
To rule out issues with MariaDB itself:

Connect to the MariaDB container:

bash
Copy code
docker exec -it mariadb bash
Log in to MySQL locally:

bash
Copy code
mysql -u"${DB_USER}" -p
Check if the database is accessible and verify that the user credentials are correct.

Step 6: Restart Services
Restart both containers to reset the network configuration:

bash
Copy code
docker-compose down
docker-compose up -d
Step 7: Verify Firewall or Host Settings
If the containers are on the same network but still cannot communicate:

Check if Docker’s internal DNS resolver is working:

bash
Copy code
docker exec -it wordpress cat /etc/resolv.conf
It should point to Docker’s DNS (e.g., 127.0.0.11).

Ensure no firewalls or external configurations are blocking communication.

Recap of Key Fixes
Ensure WP_DATABASE_HOST matches the MariaDB service name or IP address.
Verify both containers are on the same Docker network.
Use the correct credentials and test connectivity manually.
Restart the containers if necessary.
Let me know if you need further guidance!






You said:
 docker exec -it mariadb mysql -ubob -p
MariaDB [(none)]> SHOW DATABASES;
+--------------------+
| Database           |
+--------------------+
| WordPressDB        |
| information_schema |
+--------------------+
2 rows in set (0.000 sec)

shouldn't mariadb be in there aswell?
ChatGPT said:
ChatGPT
The absence of a database explicitly named mariadb in the SHOW DATABASES output is not an issue unless you expect such a database to exist for your setup. Let me clarify:

Explanation:
Default and User-Created Databases:

The SHOW DATABASES; command lists all databases currently accessible to the logged-in user.
By default, MariaDB does not create a database named mariadb. It typically includes:
information_schema: A system database for metadata.
User-created databases (e.g., WordPressDB in your case).
Your Database WordPressDB:

If WordPressDB is intended to be the database used by WordPress, this is correct and expected.
MariaDB itself does not have a "self-referencing" database; its functionality is tied to these databases and the system metadata.
Next Steps:
Verify Configuration Matches:

Ensure the DB_NAME in your .env file matches the WordPressDB you see listed here:
env
Copy code
WP_DATABASE_NAME=WordPressDB
Also ensure the environment variable WP_DATABASE_HOST points to this MariaDB server's hostname.
Verify WordPress Connection: If everything matches but WordPress is still having issues:

Confirm DB_USER and DB_USER_PASSWORD in your .env file match the credentials you're testing with mysql -ubob -p.
Test Connection from WordPress: From within the WordPress container:

bash
Copy code
docker exec -it wordpress bash
mysql -h "mariadb" -u "bob" -p "WordPressDB"
If it connects successfully, WordPress should be able to interact with the database.





### --------------------------------------------

---

# Extra INFO

###  .conf and .cnf ----------------------------
difference between `.conf` and `.cnf`

Both `.conf` and `.cnf` are commonly used for configuration files, but they are often associated with different types of applications or services.
Key Differences: 
`.conf` is more general and used by many different types of software, associated with operating system services and various servers.
`.cnf` is more specialized, often used for MySQL and database-related configurations, associated with database configurations.

### --------------------------------------------
###  Docker version ----------------------------

The version field was used in older versions of Docker Compose (pre-1.27.0) to specify the format of the configuration file and indicate which features were available in the Docker Compose specification. 
However, from Docker Compose v1.27.0 onwards, the requirement for a version field has been deprecated.

Older Docker Compose files (versioned):
Here, '3.9' specifies the schema version of the Docker Compose file.
```yaml
version: "3.9"

services: 
  mariadb:
    image: mariadb
```

Newer Docker Compose (no version field): With newer versions of Docker Compose (v1.27.0 and beyond), the version field is no longer required. You can simply define the services without specifying a version:
```yaml
services: 
  mariadb:
    image: mariadb
```

### --------------------------------------------




Nginx:
Nginx acts as a reverse proxy and web server for WordPress.
It can only serve WordPress properly if the WordPress container is already up and running, so start Nginx last.



-->
