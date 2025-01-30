# Packer Configuration for AWS EC2 with Nginx

## Overview

This Packer configuration automates the creation of an Amazon Machine Image (AMI) with **Ubuntu 20.04**, **Nginx**, and a simple HTML page that displays "Hello, World!". The setup follows best practices by relying on **environment-based AWS credentials**.

## Files Structure

- **`main.pkr.hcl`** - Declares required Packer plugins.
- **`source.pkr.hcl`** - Defines the AWS EC2 image source configuration.
- **`variables.pkr.hcl`** - Manages environment-based variables.
- **`provisioner.pkr.hcl`** - Contains the provisioning steps to install and configure Nginx.
- **`README.md`** - This documentation file.

## Prerequisites

Before running Packer, ensure the following requirements are met:

### Install Dependencies

- [Packer](https://developer.hashicorp.com/packer/tutorials/aws-get-started/install-cli)

### Set AWS Credentials

Packer uses environment variables for AWS authentication. Run the following commands to set them:

```bash
export AWS_ACCESS_KEY_ID="YOUR_ACCESS_KEY"
export AWS_SECRET_ACCESS_KEY="YOUR_SECRET_KEY"
export AWS_DEFAULT_REGION="us-east-1"
```


If running Packer from an AWS EC2 instance, attach an IAM role with necessary permissions.

## How to Build the AMI

### 1. Initialize Packer

Before building, initialize Packer to install required plugins:

```bash
packer init .
```

### 2. Build the Image

Run the following command to create the AMI:

```bash
packer build .
```

This process will:

- Launch a temporary EC2 instance
- Install and configure **Nginx**
- Create an AMI with Nginx pre-installed
- Terminate the temporary instance


