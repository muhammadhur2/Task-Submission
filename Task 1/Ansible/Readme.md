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

## Files

### `setup_hello_world_nginx.yml`

This Ansible playbook installs **Nginx**, deploys a **static HTML page**, and configures **SSL** with Let's Encrypt.

```yaml
---
- name: Set up a simple "Hello, World!" Nginx site with SSL
  hosts: all
  become: yes
  vars:
    server_name: "yourdomain.com"
    email: "youremail@example.com"

  tasks:
    - name: Update apt cache and install Nginx
      apt:
        update_cache: yes
        name: nginx
        state: present

    - name: Install Certbot
      apt:
        name: certbot
        state: present

    - name: Install python3-certbot-nginx
      apt:
        name: python3-certbot-nginx
        state: present

    - name: Create directory for static content
      file:
        path: /var/www/hello
        state: directory
        owner: www-data
        group: www-data
        mode: '0755'

    - name: Deploy "Hello, World!" index.html
      copy:
        content: |
          <html>
          <head>
            <title>Hello World</title>
          </head>
          <body>
            <h1>Hello, World!</h1>
            <p>This is a simple Nginx website served via HTTPS.</p>
          </body>
          </html>
        dest: /var/www/hello/index.html
        owner: www-data
        group: www-data
        mode: '0644'

    - name: Configure Nginx (using a template)
      template:
        src: nginx.conf.j2
        dest: /etc/nginx/sites-available/{{ server_name }}
        owner: root
        group: root
        mode: '0644'

    - name: Enable site configuration
      file:
        src: /etc/nginx/sites-available/{{ server_name }}
        dest: /etc/nginx/sites-enabled/{{ server_name }}
        state: link

    - name: Remove the default Nginx site (optional, to avoid conflicts)
      file:
        path: /etc/nginx/sites-enabled/default
        state: absent

    - name: Test Nginx configuration
      command: nginx -t
      notify:
        - reload nginx

    - name: Obtain SSL certificate (Certbot + Nginx plugin)
      command: certbot --nginx -d {{ server_name }} --non-interactive --agree-tos --email {{ email }}
      notify:
        - reload nginx

  handlers:
    - name: reload nginx
      service:
        name: nginx
        state: reloaded
```

---

### `nginx.conf.j2`

This is the **Nginx configuration template** used by the playbook.

```nginx
server {
    listen 80;
    server_name {{ server_name }};

    # Serve the Hello World static content
    root /var/www/hello;
    index index.html;

    location / {
        try_files $uri $uri/ =404;
    }
}
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

