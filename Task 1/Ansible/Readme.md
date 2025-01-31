# Nginx Hello World Deployment with Ansible

This repository contains an Ansible playbook for setting up an **Nginx web server** that serves a simple **"Hello, World!"** page at the root (`/`). It also **automatically configures SSL** using **Certbot** and **Let's Encrypt**.

## Features

- Installs **Nginx** on a remote server (e.g., an EC2 instance)
- Deploys a **static HTML "Hello, World!"** page
- Configures **Nginx** to serve the page at the root (`/`)
- **Removes the default Nginx configuration** to avoid conflicts
- **Obtains an SSL certificate** from Let's Encrypt using Certbot
- **Automatically configures HTTPS** using the Certbot Nginx plugin

---

## Prerequisites

- **A remote server** (e.g., an Ubuntu EC2 instance)
- **A domain name** (e.g., `yourdomain.com`) pointing to the server's IP
- **Ansible installed on your local machine**
- **SSH access** to the server with a private key

---

## Usage

### 1️⃣ Update Your Inventory File

You can either add your server to Ansible's inventory file or use an inline host.

### 2️⃣ Run the Playbook

Replace `<your_server_ip_or_dns>`, `<path_to_your_ec2_key.pem>`, `yourdomain.com`, and `youremail@example.com` with your actual values.

```bash
ansible-playbook -i <your_server_ip_or_dns>, \
  -u ubuntu --private-key <path_to_your_ec2_key.pem> \
  setup_hello_world_nginx.yml \
  -e server_name=yourdomain.com \
  -e email=youremail@example.com
```

---


## After Deployment

Once the playbook runs successfully:

1. Open your browser and visit:  
   **`http://yourdomain.com`** → You should see **"Hello, World!"**  
   
2. If the SSL certificate was issued correctly, visit:  
   **`https://yourdomain.com`** → The page should be served over **HTTPS**.  

3. Run the following command to verify the SSL certificate:  
   ```bash
   sudo certbot certificates
   ```

---

