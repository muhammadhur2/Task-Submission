# Docker Setup Script

## Overview

This script automates the installation of Docker, sets up a MySQL database and a Node.js application using Docker Compose, and configures the necessary environment variables.

## Features

- Installs Docker and its dependencies on Ubuntu

- Configures a MySQL database in a Docker container

- Deploys a Node.js application in a Docker container

- Uses Docker Compose to manage services

- Automatically sets up environment variables

## Prerequisites

Ensure that you are running Ubuntu and have sudo privileges before executing this script.

## Installation and Usage

1. Clone the Script


2. Grant Execute Permission

Make the script executable:

```
chmod +x docker-script.sh
```

3. Run the Script

Execute the script with:

```
./docker-script.sh
```

4. Verify Running Containers

After the script completes, check that the Docker containers are running:

```
docker ps
```