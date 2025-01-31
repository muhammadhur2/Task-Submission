#!/bin/bash

set -e  # Exit on error

# Update package list and install dependencies
echo "Updating package list and installing dependencies..."
sudo apt-get update
sudo apt-get install -y ca-certificates curl

# Add Docker's official GPG key
echo "Adding Docker's official GPG key..."
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add Docker repository
echo "Adding Docker repository..."
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Update package list again
echo "Updating package list again..."
sudo apt-get update

# Install Docker and related packages
echo "Installing Docker and related components..."
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Create docker-compose.yml
echo "Creating docker-compose.yml file..."
cat <<EOF > docker-compose.yml
networks:
  mynetwork:
    driver: bridge

services:
  mysql:
    image: mysql:latest
    container_name: mysql-container
    restart: always
    env_file:
      - .env.docker
    environment:
      MYSQL_ROOT_PASSWORD: \${DB_PASSWORD}
      MYSQL_DATABASE: \${DB_NAME}
    ports:
      - "3306:3306"
    volumes:
      - mysql_data1:/var/lib/mysql
    networks:
      - mynetwork

  app:
    image: muhammadhur/nodejsapp:latest
    container_name: nodejsapp
    restart: always
    depends_on:
      - mysql
    env_file:
      - .env.docker
    environment:
      DB_HOST: \${DB_HOST}
      DB_USER: \${DB_USER}
      DB_PASSWORD: \${DB_PASSWORD}
      DB_NAME: \${DB_NAME}
      PORT: \${PORT}
    ports:
      - "\${PORT}:\${PORT}"
    networks:
      - mynetwork

volumes:
  mysql_data1:
EOF

# Create .env.docker file
echo "Creating .env.docker file..."
cat <<EOF > .env.docker
DB_HOST=mysql
DB_USER=root
DB_PASSWORD=my-secret-pw
DB_NAME=mydatabase
DB_PORT=3306
PORT=3005
EOF

# Run Docker Compose
echo "Starting Docker containers..."
docker compose --env-file .env.docker up -d --build

echo "Setup completed successfully!"
