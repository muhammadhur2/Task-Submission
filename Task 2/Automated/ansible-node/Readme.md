# Ansible Playbook for Docker Setup and Application Deployment

## Overview

This Ansible playbook automates the setup of Docker and deploys a MySQL database along with a Node.js application using Docker Compose on an Ubuntu server.

## Features

- Installs Docker and its dependencies

- Configures a MySQL database in a Docker container

- Deploys a Node.js application in a Docker container

- Uses Docker Compose to manage services

- Automatically sets up environment variables

## Prerequisites

Ensure that:

- The target machine runs Ubuntu

- You have Ansible installed on your local machine

- The remote server is accessible via SSH

- You have the correct private key to connect to the remote server

## Configuration

### Inventory File (inventory.ini)

Ensure your inventory file **(inventory.ini)** contains the correct server details:

[servers]
192.168.10.183 ansible_user=ubuntu ansible_ssh_private_key_file=~/ansible-node/key.pem


## Running the Playbook

1. Ensure you are in the directory containing the Ansible playbook.

2. Run the playbook using the following command:

```
ansible-playbook -i inventory.ini setup-docker.yml
```


### Verifying the Deployment

Once the playbook completes, check if the Docker containers are running:

```
docker ps
```

