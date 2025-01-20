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

<br>
<br>

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

### Dockerfile Directives
**1. FROM** <br>
- `Purpose:`  <br>
Specifies the base image for the container. <br>
The base image acts as the foundation of your container and may already include essential software or libraries. <br>
- `Importance:` <br>
This is a mandatory directive and must appear as the first line in any Dockerfile.<br>
- `Details:` <br>
    - It defines the starting point for your container’s filesystem. <br>
    - Choosing the right base image can significantly reduce build time and simplify your Dockerfile. <br>
    **For example**, using a lightweight image like alpine can save space, whereas more feature-rich images like debian or ubuntu are better for compatibility. <br>

**2. WORKDIR** <br>
- `Purpose:` <br>
Sets the working directory for any RUN, CMD, ENTRYPOINT, COPY, and ADD instructions that follow. <br>
- `Importance:` <br>
Optional, but useful when your application relies on relative paths or if you want a predictable directory structure within the container.<br>
- `Details:` <br>
    - Without WORKDIR, commands must use absolute paths, which can make your Dockerfile harder to read and maintain. <br>
    - If WORKDIR is not explicitly set, the default working directory is / *(the root directory)*. <br>

**3. ENV** <br>
- `Purpose:` <br>
Defines environment variables inside the container. <br>
These variables can configure the application, store secrets, or control runtime behavior.<br>
- `Importance:` <br>
Optional, but highly recommended for flexibility and reusability.<br>
- `Details:`<br>
    - Environment variables can be overridden at runtime using the docker run --env or --env-file options.<br>

**4. COPY** <br>
- `Purpose:` <br>
Copies files and directories from the build context on your host machine into the container’s filesystem.<br>
- `Importance:` <br>
Essential if your application or script requires external files *(source code, configuration files)*.<br>
- `Details:`<br>
    - Use COPY for simple, static file transfers.<br>
    - For more complex operations like downloading files or extracting archives, <br>
     use ADD *(though ADD is less commonly recommended due to its broader functionality and potential for unintended side effects)*.<br>

**5. EXPOSE** <br>
- `Purpose:` <br>
Documents the port(s) the container listens on at runtime.<br>
- `Importance:` <br>
Optional and informational only—it does not actually expose the port on the host.<br>
- `Details:`<br>
    - While optional, using EXPOSE helps other developers or tools understand which ports the container is designed to use.<br>
    
**6. ENTRYPOINT** <br>
- `Purpose:` <br>
Specifies the main process that will run when the container starts. <br>
It is used to make the container behave like a standalone executable.<br>
- `Importance:` <br>
Optional, but powerful for containers intended to run a single, dedicated task.<br>
- `Details:`<br>
    - ENTRYPOINT is designed to run as the container’s primary process and cannot be easily overridden with additional commands at runtime.<br>
    - It pairs well with CMD, which provides default arguments to the ENTRYPOINT.<br>
    
**7. CMD** <br>
- `Purpose:` <br>
Provides default instructions or arguments to be passed to the container’s main process.<br>
- `Importance:` <br>
Optional, but a best practice if you want your container to perform a default action.<br>
- `Details:`<br>
    - If both ENTRYPOINT and CMD are specified, CMD provides arguments to the ENTRYPOINT.<br>
    - If only CMD is used, it serves as the main command to execute.<br>
    - When no ENTRYPOINT is specified, CMD will directly run the provided command, making it sufficient for many simple containers.<br>
    - **For example**, you could specify CMD ["/bin/bash", "script.sh"] instead of setting up ENTRYPOINT<br>

<br>

**Example of a simple Dockerfile:**
```dockerfile
# Use the official MariaDB image as the base image
FROM mariadb:10.6

# Set the working directory inside the container
WORKDIR /docker-entrypoint-initdb.d

# Environment variables to configure MariaDB
# MYSQL_ROOT_PASSWORD is required for MariaDB to initialize
ENV MYSQL_ROOT_PASSWORD=mysecurepassword \
    MYSQL_DATABASE=myappdb \
    MYSQL_USER=myappuser \
    MYSQL_PASSWORD=appsecurepassword

# Copy custom initialization scripts into the container
# These scripts are executed when the container is started
COPY ./init-scripts/ /docker-entrypoint-initdb.d/

# Expose the default MariaDB port
EXPOSE 3306

# Add an ENTRYPOINT to ensure the official MariaDB entrypoint is used
ENTRYPOINT ["docker-entrypoint.sh"]

# The CMD specifies the default arguments for the ENTRYPOINT
CMD ["mysqld"]
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
  <summary><strong>➡️Example docker-compose.yml⬅️</strong></summary>

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
  <summary><strong>⭐Docker Compose Commands</strong></summary>

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

WordPress relies on a database to store its data. <br>
The MariaDB container provides this, so it needs to be up and running first.<br>
This ensures WordPress can connect to the database as soon as it starts.<br> <br>

Set up a MariaDB container with custom configuration: <br>
- `Dockerfile` : <br>
Defines the MariaDB image build process, including installing tools and copying configuration files.<br>
- `Initialization Script (db-script.sh)` : <br>
Automates database initialization, user creation, and permission setup, and ensures MariaDB runs in the foreground. <br>
- `Custom Configuration File (db-config.cnf)` : <br>
Configures MariaDB server settings such as ports, caching, logging, and character sets. <br> <br>

### 👽SCRIPT

❗NOTE: <br>
This is the "shebang" line ```#!/bin/bash``` <br>
It tells the system that the script should be executed using /bin/bash, a common Unix shell. <br>
You alway need this line at the top of your script.sh! <br> <br>


The script prepares the environment, initializes the database, <br>
configures security, and ensures MariaDB runs continuously. <br><br>

***Initialization Script:*** *Key Steps* <br>
- **1. Environment Setup:** <br>
  - Create/move necessary directories for data and logs. <br>
  - Set appropriate permissions for MariaDB access. <br>
- **2. Database Initialization:** *(This Step can be different for everyone)* <br>
  - Reloading privilege tables: <br>
      - `CREATE DATABASE:` Adds a database with specified name. <br>
      - `CREATE USER:` Adds a new user with a specified password. <br>
      - `GRANT ALL PRIVILEGES:` Gives the new user full access to the specified database. <br>
      - `FLUSH PRIVILEGES:` Refreshes the privilege tables to apply changes. <br>
      - Use `--bootstrap` option *(Makes it easier)* <br>
- **3. Keep MariaDB Running in the Foreground:** <br>
  - Uses `exec mysqld` to keep MariaDB running in the foreground, essential for containerized environments. <br><br>


### 👽--bootstrap

The --bootstrap option starts MariaDB in a lightweight, isolated mode for initialization: <br>
- Disables networking and plugins for safe setup. <br>
- Runs initialization scripts for tasks like: <br>
    - Creating system databases. <br>
    - Configuring initial users and permissions. <br>
- Exits automatically after setup, ensuring efficient and conflict-free initialization. <br>
- No external connections or conflicts occur during setup. <br>
- It’s a safe way to run one-time initialization scripts programmatically without starting the full server. <br><br>

### 👽Configuration File: db-config.cnf

### .conf and .cnf

Both `.conf` and `.cnf` are commonly used for configuration files, <br>
but they are often associated with different types of applications or services. <br>


| **File Extension** | **Usage**                                                                 | **Associated With**                                    |
|--------------------|---------------------------------------------------------------------------|-------------------------------------------------------|
| `.conf`            | General-purpose configuration files for many types of software.          | Operating system services and various servers.        |
| `.cnf`             | Specialized configuration files, primarily for MySQL and MariaDB settings. | Database-related configurations.                      |

<br>


The db_config.cnf file is a configuration file for the MariaDB server, <br>
specifically for setting server-side options that control database behavior, storage, networking, and performance. <br>
See examples on [IMB](https://www.ibm.com/docs/en/ztpf/2023?topic=performance-mariadb-configuration-file-example) or [GitHub](https://gist.github.com/fevangelou/fb72f36bbe333e059b66). <br>


<details>
  <summary><strong>🔸Explanation of variable options</strong></summary>
  <br>

## Explanation of variable options:

**Sections: General Server Configuration Sections** <br>
The configuration file is divided into sections *(like [mysqld], [mariadb], etc.)* <br>
that specify settings for different components of the MariaDB server. <br>
Each section can contain specific settings related to that component. <br>
- `[server]` : This section applies to the entire MariaDB server, both for standalone and embedded servers. <br>
- `[mysqld]` : Settings in this section apply only to the mysqld standalone MariaDB server daemon. <br>
- `[embedded]`, `[mariadb]`, `[mariadb-10.3]` : These sections define options specific to embedded servers, <br>
MariaDB-specific options, and MariaDB version-specific settings, respectively.

### Basic Settings
**User and PID file settings**<br>
- `user` : Sets the user under which the MariaDB server runs.<br>
- `pid-file` : Path for the PID file, which helps manage the MariaDB process. <br><br>

**Socket and Port settings** <br>
- `socket` : Location of the MariaDB Unix socket file for local connections.<br>
- `port` : Sets the port for TCP/IP connections *(default MySQL/MariaDB port)*.<br><br>

**Directories settings**<br>
- `basedir` : Base directory where MariaDB is installed.<br>
- `datadir` : Directory for storing database files.<br>
- `tmpdir` : Temporary files directory used by the server.<br>
- `lc-messages-dir` : Directory for error messages and translations.<br><br>

**Network settings**<br>
- `bind-address` : Specifies the network interface on which MariaDB listens for incoming connections. <br>
Setting this to 0.0.0.0 means it accepts connections from all interfaces.<br><br>

**Fine Tuning**<br>
This section contains various parameters that can fine-tune the performance of the server.<br>
Example parameters:<br>
- `key_buffer_size        = 16M`<br>
- `max_allowed_packet     = 16M`<br>
- `thread_stack           = 192K`<br>
- `thread_cache_size      = 8`<br>
- `myisam_recover_options = BACKUP`<br>
- `max_connections        = 100`<br>
- `table_cache            = 64`<br>
- `thread_concurrency     = 10`<br><br>

**Query Cache Configuration**<br>
- `query_cache_size` : Size of the query cache, which stores results of queries to improve performance.<br><br>

**Logging and Replication**<br>
- `log_error` : Path to the error log file, which is crucial for troubleshooting.<br>
- `expire_logs_days` : Number of days to keep binary logs before they are automatically removed.<br><br>

**Settings for general logging and slow query logging if desired:**<br>
- `general_log_file       = /var/log/mysql/mysql.log`<br>
- `general_log            = 1`<br>
- `slow_query_log_file    = /var/log/mysql/mariadb-slow.log`<br>
- `long_query_time        = 10`<br>
- `log_slow_rate_limit    = 1000`<br>
- `log_slow_verbosity     = query_plan`<br>
- `log-queries-not-using-indexes`<br><br>

**Replication setup**<br>
- `server-id              = 1`<br>
- `log_bin                = /var/log/mysql/mysql-bin.log`<br>
- `max_binlog_size        = 100M`<br>
- `binlog_do_db           = include_database_name`<br>
- `binlog_ignore_db       = exclude_database_name`<br><br>

**Security Features**<br>
Security configurations related to connections and SSL.<br>
Uncomment and configure if required.<br>
- `chroot = /var/lib/mysql/`<br>
- `ssl-ca = /etc/mysql/cacert.pem`<br>
- `ssl-cert = /etc/mysql/server-cert.pem`<br>
- `ssl-key = /etc/mysql/server-key.pem`<br>
- `ssl-cipher = TLSv1.2  # Ensure the latest TLS protocol is used for secure connections.`<br><br>

**Character Sets**<br>
Character set settings to support various languages and symbols.<br>
- `character-set-server` : Defines the default character set for the server.<br>
- `collation-server` : Defines the default collation for string comparison.<br><br>

**Unix Socket Authentication Plugin**<br>
This is for Unix socket authentication, allowing the root user to authenticate without a password when running as the Unix root user.<br>
See [authentication plugin](https://mariadb.com/kb/en/unix_socket-authentication-plugin/) for details.<br><br>

**this is only for embedded server**<br>
[embedded]<br><br>

**This group is only read by MariaDB servers, not by MySQL.**<br>
**If you use the same .cnf file for MySQL and MariaDB,**<br>
**you can put MariaDB-only options here.**<br>
[mariadb]<br><br>

**This group is only read by MariaDB-10.3 servers.**<br>
**If you use the same .cnf file for MariaDB of different versions,**<br>
**use this group for options that older servers don't understand.**<br>
[mariadb-10.3]<br><br>

<br> <br>

</details>

<details>
  <summary><strong>🔸Simple Config.cnf Example</strong></summary>
  <br>

## Simple Config.cnf Example:

```config
# MySQL Server Configuration File

[server]
# General server settings can be placed here. This section is commonly left blank
# because most configurations are defined under the `[mysqld]` section.

[mysqld]
# Settings for the MySQL daemon (server).

user                    = mysql                         # The user under which the MySQL server runs.
pid-file                = /run/mysqld/mysqld.pid        # File containing the process ID of the MySQL server.
socket                  = /var/run/mysqld/mysqld.sock   # Unix socket for local connections.
port                    = 3306                          # Port for MySQL to listen on (default is 3306).
basedir                 = /usr                          # Base directory of the MySQL installation.
datadir                 = /var/lib/mysql                # Directory where MySQL data files are stored.
tmpdir                  = /tmp                          # Temporary directory used for operations like sorting.
lc-messages-dir         = /usr/share/mysql              # Directory containing language files for error messages.
bind-address            = 0.0.0.0                       # Listen on all network interfaces to allow external connections.
query_cache_size        = 16M                           # Amount of memory allocated for caching query results.
log_error               = /var/log/mysql/error.log      # File to store error logs.
log-bin                 = /var/log/mysql/mysql-bin.log  # Binary log file for replication and recovery.
expire_logs_days        = 10                            # Automatically remove binary logs older than 10 days.
character-set-server    = utf8mb4                       # Default character set for the server.
collation-server        = utf8mb4_general_ci            # Default collation for the server.
innodb_use_native_aio   = 0                             # Disable native asynchronous I/O (useful for certain environments).

[client]
# Configuration for MySQL client tools.

default-character-set = utf8mb4               # Default character set for client connections.

[embedded]
# Settings for embedded MySQL server (if used). Typically left blank unless embedding is required.

[mariadb]
# Specific settings for MariaDB server. This section can be used for MariaDB-specific configurations.

[mariadb-10.3]
# Settings specific to MariaDB version 10.3. This section allows version-specific configurations.
```
<br> <br>

</details>

<br><br>

### 👽Testing the MariaDB Setup 

**1. Build and Start the Container:** <br>
- View Logs: **(fix them first)**<br>
```bash
docker-compose logs mariadb
```
<br>

**2. Enter the  container:** <br>
```bash
docker exec -it <mariadb_container_name> bash
```
<br>

**3. Access MariaDB:** <br>
```bash
mysql -u root -p
```
<br>
 
**4. Verify Database Creation:** <br>
```sql
# SHOW DATABASES;
```
**->** Make sure your database *(your_database_name)* is listed. <br>

**Should look like:**<br>
```sql
MariaDB [(none)]> SHOW DATABASES;
+--------------------+
| Database           |
+--------------------+
| information_schema |
| mysql              |
| performance_schema |
| wordpress          |
+--------------------+
```

<br>

**5. Verify User Creation:** <br>
```sql
# SELECT User, Host FROM mysql.user;
```
**->** This should list your USER. <br>
**->** Your USER should have the %. <br>

**Should look like:** <br>
```sql
MariaDB [(none)]> SELECT User, Host FROM mysql.user;
+------+-----------+
| User | Host      |
+------+-----------+
| bob  | %         |
| root | localhost |
+------+-----------+
```
<br>

**6. Check User Permissions:** <br>
```sql
# SHOW GRANTS FOR '<USER>'@'%';
```

**Should look like:**
```sql
MariaDB [(none)]> SHOW GRANTS FOR 'bob'@'%';
+----------------------------------------------------------------------------------------------------+
| Grants for bob@%                                                                                   |
+----------------------------------------------------------------------------------------------------+
| GRANT USAGE ON *.* TO `bob`@`%` IDENTIFIED BY PASSWORD '*61584B76F6ECE8FB9A328E7CF198094B2FAC55C7' |
+----------------------------------------------------------------------------------------------------+
```
<br>

🍀 **If all steps are successful, MariaDB is properly configured and running with the correct settings.** 🍀 <br><br>

---


### 🍿WordPress

Once MariaDB is up, start the WordPress container. <br>
During startup, WordPress will try to connect to the database, so having MariaDB ready beforehand is essential. <br>
WordPress will connect to MariaDB using environment variables *(like database host, username, and password)*<br>
in your docker-compose.yml file or Docker run command. <br><br>

***Important Considerations:*** <br>
`PHP and Debian/Alpine:` Use the latest stable versions of PHP and your operating system. <br>
Avoid specifying PHP versions like php-fpm7.4 or php-fpm8.2; instead, use php-fpm to default to the latest installed version. <br><br>

### 👽SCRIPT

❗NOTE: <br>
This is the "shebang" line ```#!/bin/bash``` <br>
It tells the system that the script should be executed using /bin/bash, a common Unix shell. <br>
You alway need this line at the top of your script.sh! <br> <br>

***Initialization Script:*** *Key Steps* <br>
- **1. Environment Setup:** <br>
  - Create/move necessary directories. <br>
  - Set up directories for data and logs with proper permissions. <br>
- **2. Check for Configuration Files:** *(This Step can be different for everyone)* <br>
  - Verify if wp-config.php or index.php exists. If not, use WP-CLI to create them: <br>
    - Use `mysqladmin` to connect to the database (preferred over mysql). <br>
    - Only do this if you **DON'T** have a manuall wp-config.php <br>
    	- Create WordPress configuration *(wp config create [Syntax](https://developer.wordpress.org/cli/commands/config/create/))* <br>
    - *(Different wp commands [Subcommands](https://developer.wordpress.org/cli/commands/config/))* <br>
    - Install WordPress/ Wordpress Admin *(wp core install [Syntax](https://developer.wordpress.org/cli/commands/core/install/))* <br>
		- Create a WordPress user *(wp user create [Syntax](https://developer.wordpress.org/cli/commands/user/create/))* <br>
 		- Don't forget to add --role=editor or --role=author <br>
- **4. Keep the Service Running:**
  - Ensure PHP-FPM runs in the foreground for Dockerized environments. *(/usr/sbin/php-fpm8.2 -F)* <br><br>


### 👽Configuration Details: wp-config.php

I don't recommand doing a wp-config manually **(for the Inception project)** <br>
You need to pass the .env variables, but that is a bit more difficult, <br>
because using `getenv()` is not working quite easily as you think it will. <br>
You could hardcode the variables, which defeats the purpose of the .env variables. <br>
The best way is creating WordPress Configuration with 'wp config create'. <br><br>


<details>
  <summary><strong>🔸But If you want to create a wp-config.php manually</strong><em> OR for intrest</em></summary>

## Manual Configuration (Optional):

1. Refer to [this example wp-config.php](https://www.vodien.com/help/article/how-to-create-wp-config-php-file) <br>
2. Generate security keys and salts using the [WordPress Secret Key Generator](https://api.wordpress.org/secret-key/1.1/salt/) <br>
The values for AUTH_KEY, SECURE_AUTH_KEY, etc., are security keys and salts that WordPress <br>
uses for encrypting information stored in user cookies. You can generate new ones with the URL. <br><br>

**Example Comparison:** <br>
```plaintext
                    HardCoded Example       |           Recommended (using getenv)      
        ------------------------------------|---------------------------------------------
                                            |
define( 'WP_DATABASE_NAME', 'wordpress' );  |       define( 'WP_DATABASE_NAME', getenv('WP_DATABASE_NAME'));
define( 'DB_USER', 'user' );                |       define( 'DB_USER', getenv('MYSQL_USER')); 
define( 'DB_USER_PASSWORD', 'pwd' );        |       define( 'DB_USER_PASSWORD', getenv('MYSQL_USER_PASSWORD'));
define( 'DB_HOST', 'mariadb' );             |       define( 'DB_HOST', getenv('MYSQL_HOST')); 
define( 'DB_CHARSET', 'utf8' );             |       define( 'DB_CHARSET', 'utf8' );
define( 'DB_COLLATE', '' );                 |       define( 'DB_COLLATE', '' );

```
<br>

</details>

<br>

### 👽PHP-FPM Configuration (.ww.conf)

The .ww.conf file plays a critical role in configuring PHP-FPM for your WordPress container. <br>
By default, PHP-FPM uses its standard .ww.conf file, which may not meet your container’s requirements,<br>
such as listening on the correct port or applying optimal resource limits. <br>
If not properly configured, your container could experience performance issues or <br>
fail to connect to NGINX or other services. <br><br>

**Why Customize .ww.conf?** <br>
- `Port Configuration:` <br>
Ensure PHP-FPM listens on the correct port (e.g., port 9000) <br>
for communication with services like NGINX. <br>
- `Resource Management:` <br>
Adjust process management settings to match your container’s <br>
workload and prevent underutilization or resource waste. <br>
- `Compatibility:` <br>
Avoid unexpected behavior caused by default settings <br>
that may not align with your containerized environment. <br><br>

**Applying a Custom .ww.conf** *(Dockerfile)* <br>
- Copy to /etc/php/8.2/fpm/pool.d/ *(overwrite)* <br>
This ensures your custom settings are applied when the container runs. <br><br>

**Example .ww.conf:**
```ini
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
```
<br><br>


### 👽Testing the WordPress Setup

**1. Build and Start the Container:** <br>
  - View Logs: **(fix them first)**
```bash
docker-compose logs wordpress
```
<br>

**2. Enter the WordPress container:** <br>
```bash
docker exec -it <wordpress_container_name> bash
```
<br>

**3. Navigate to the WordPress directory:**<br>
```bash
ls /var/www/html/wordpress
```
**->** Ensure required files *(e.g., index.php, wp-config.php)* are present. <br>
<details>
  <summary><strong>Example</strong></summary>


## Example:

```plaintext
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
```

<br>

</details>

<br>

**4. Inspect the Docker network:** <br>
```bash
docker network inspect <network_name>
```
<br>


**5. Verify all containers** *(WordPress, MariaDB, NGINX)* **are listed and reachable:** <br>
**->** confirm the IPv4 Address are reachable on this network (172.18.0.x). <br>
**Something like that:** 
```plaintext
[...]
Network Name: inception_net
Containers Connected:
    wordpress:
        [...]
        IPv4 Address: 172.18.0.3
    mariadb:
        [...]
        IPv4 Address: 172.18.0.2
    nginx:
        [...]
        IPv4 Address: 172.18.0.4
[...]
```
<br>

**6. Access WordPress:** <br>
Open your browser and navigate to: ```https://<DOMAIN_NAME>```

<br>

---


### 🍿Nginx

# NGINX

Nginx acts as a reverse proxy and web server for WordPress. <br>
It can only serve WordPress properly if the WordPress container <br>
is already up and running, so start Nginx last. <br><br>

Set up a Nginx container with custom configuration:<br>
- `Dockerfile:` <br>
 Defines the Nginx image build, installs necessary tools, <br>
 and copies configuration files into the container.<br>
- `Custom Configuration File (nginx-config.conf):` <br>
 Contains Nginx server configurations. <br>
- `Optional Initialization Script (nginx-script.sh):` <br>
 Performs tasks such as creating SSL certificates *(this can also be done within the Dockerfile)*. <br><br>

### 👽SCRIPT

❗NOTE: <br>
This is the "shebang" line ```#!/bin/bash``` <br>
It tells the system that the script should be executed using /bin/bash, a common Unix shell. <br>
You alway need this line at the top of your script.sh! <br> <br>

The script *(nginx-script.sh)* is **optional** and can create a self-signed SSL certificate for TLS. <br>
You may also integrate this step into the Dockerfile.<br><br>

**script.sh:** <br>
```bash
echo "Creating a self-signed SSL certificate..."
openssl req \
    -x509 \
    -nodes \
    -days 365 \
    -newkey rsa:2048 \
    -subj "/C=NL/ST=Holland/L=Amsterdam/O=Codam/CN=${DOMAIN_NAME}" \
    -out "/etc/nginx/ssl/selfsigned.crt" \
    -keyout "/etc/nginx/ssl/selfsigned.key"
```
<br>

**Explanation of Key Options:** <br>
- `(-days 365)` : Generates a certificate valid for one year.<br>
- `(-out) and (-keyout)` : Specify paths for the certificate and private key.<br>
- `(-subj)` : Contains the certificate details:<br>
  - `C=` : Country<br>
  - `ST=` : State or Province<br>
  - `L=` : Locality *(City)*<br>
  - `O=` : Organization<br>
  - `CN=` : Common Name *(Domain Name)*<br>
  
openssl req [syntax](https://knowledge.digicert.com/general-information/openssl-quick-reference-guide)
<br><br>

### 👽Configuration File (nginx-config.conf)

<details>
  <summary><strong>🔸Key Directives</strong></summary>
  <br>

## Key Directives:


**Listening for SSL**
```nginx
listen 443 ssl;
listen [::]:443 ssl;
```
These lines bind both IPv4 and IPv6 addresses to port 443 for SSL. <br>

**Server Name**
```nginx
server_name $DOMAIN_NAME www.$DOMAIN_NAME localhost;
```
Defines the server's domain names. <br>

**SSL Settings**
```nginx
ssl_certificate /etc/nginx/ssl/selfsigned.crt;
ssl_certificate_key /etc/nginx/ssl/selfsigned.key;
ssl_protocols TLSv1.2 TLSv1.3;
ssl_ciphers HIGH:!aNULL:!MD5;
ssl_prefer_server_ciphers on;
```
Ensure that the file paths match the generated certificate and key. <br>
Modern TLS protocols *(1.2 and 1.3)* are enabled for security. <br>

**Static File Handling**
```nginx
root /var/www/html;
index index.html index.php;
try_files $uri $uri/ =404;
```
`root:` Specifies the document root. <br>
`index:` Defines default files to serve. <br>
`try_files:` Attempts to load the requested file or directory; otherwise, returns a 404 error. <br>

**PHP Support**
```nginx
location ~ \.php$ {
    fastcgi_pass wordpress:9000;
    fastcgi_index index.php;
    include fastcgi_params;
    fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
    fastcgi_param PATH_INFO $fastcgi_path_info;
}
```
This block assumes a FastCGI server *(like PHP-FPM)* is available at wordpress:9000. <br><br>

</details>

<br>

***Suggested Configuration*** *(nginx-config.conf)*:
```nginx
server {
    listen 443 ssl;
    listen [::]:443 ssl;
    server_name $DOMAIN_NAME www.$DOMAIN_NAME localhost;

    # SSL Settings
    ssl_certificate /etc/nginx/ssl/selfsigned.crt;
    ssl_certificate_key /etc/nginx/ssl/selfsigned.key;
    ssl_protocols TLSv1.2 TLSv1.3;
    ssl_ciphers HIGH:!aNULL:!MD5;
    ssl_prefer_server_ciphers on;

    # File Handling
    root /var/www/html;
    index index.html index.php;
    try_files $uri $uri/ =404;

    # PHP Handling
    location ~ \.php$ {
        fastcgi_pass wordpress:9000;
        fastcgi_index index.php;
        include fastcgi_params;
        fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
        fastcgi_param PATH_INFO $fastcgi_path_info;
    }
}
```
<br>

### 👽Using DOMAIN_NAME

To use a custom domain name *(e.g., https://<DOMAIN_NAME>)*, <br>
add the following entry to your **/etc/hosts** file: ```127.0.0.1 <DOMAIN_NAME>```
<br> <br>

### 👽HTTP vs HTTPS

**HTTPS** *(HyperText Transfer Protocol Secure)* offers significant advantages over **HTTP**,<br>
**including:**<br>
- `Encryption:` Secures data using SSL/TLS protocols. <br>
- `Authentication:` Verifies server identity to prevent phishing attacks. <br>
- `Trust:` Modern browsers display a padlock icon for HTTPS websites. <br>
- `SEO Benefits:` Search engines favor HTTPS for better rankings. <br><br>


### 👽Testing the Nginx Setup

**1. Build and Start the Container:** <br>
- View Logs: **(fix them first)**
```bash
docker-compose logs nginx
```
<br>

**2. Paths correct:** <br>
Ensure the paths in the configuration file match the generated certificate and key. <br>
**Espacilly:** <br>
```plaintext
ssl_certificate         /etc/ssl/certs/nginx-selfsigned.crt;      |       -out "/etc/nginx/ssl/selfsigned.crt" 
ssl_certificate_key     /etc/ssl/private/nginx-selfsigned.key;    |       -keyout "/etc/nginx/ssl/selfsigned.key"

```
<br>

**3. Permissions:** <br>
Verify correct permissions for the **/etc/nginx/ssl** directory. <br>

**4. Don't Panic:** <br>
Your docker logs might print something like this: <br> 
```objectivec
Create a self-signed SSL certificate...
.+...+.+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*...........+...
[...]
```
This part is generated by the openssl req command, which is used to generate a self-signed SSL certificate. <br>
The characters `+`, `*`, and `.` represent the progress of the SSL certificate generation process,<br>
which is normal output for OpenSSL commands. <br>
These are just indicators of the internal progress, <br>
but they don't affect the result of the SSL certificate creation. <br>

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

- Docker:
	- [Docker Compose Documentation](https://docs.docker.com/compose/)
	- [Multi-Container Applications](https://docs.docker.com/get-started/docker-concepts/running-containers/multi-container-applications/)
	- [Docker Volumes](https://docs.docker.com/engine/storage/volumes/)
	- [Docker Daemon](https://www.geeksforgeeks.org/what-is-docker-daemon/)
	- [Docker Overview](https://docs.docker.com/get-started/docker-overview/)
	- [GitHub ReadME](https://github.com/Forstman1/inception-42/blob/main/README.md)

- WordPress:
	- [WordPress Docker Setup](https://www.datanovia.com/en/lessons/wordpress-docker-setup-files-example-for-local-development/)
	- [WordPress and Dockerfiles](https://www.massolit-media.com/tech-writing/wordpress-and-docker-dockerfiles/)
	- [WordPress `wp-config`](https://developer.wordpress.org/advanced-administration/wordpress/wp-config/)
	- [WordPress Deployment](https://medium.com/swlh/wordpress-deployment-with-nginx-php-fpm-and-mariadb-using-docker-compose-55f59e5c1a)

- MariaDB:
	- [MariaDB Custom Container Image](https://mariadb.com/kb/en/creating-a-custom-container-image/)

- Nginx:
	- [NGINX Docker Image](https://www.docker.com/blog/how-to-use-the-official-nginx-docker-image/)
