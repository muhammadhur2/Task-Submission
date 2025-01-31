# Terraform Infrastructure for Web Server and Database

## Overview

This Terraform project provisions a **VPC-based infrastructure** in AWS with the following components:

1. **VPC with Public & Private Subnets**  
   - Two **public subnets** for an **Application Load Balancer (ALB)** and **EC2 instance**.  
   - Two **private subnets** for an **RDS MySQL database**.  
   - An **Internet Gateway** for internet access from the public subnets.

2. **Networking & Security Groups**  
   - ALB allows **HTTP/HTTPS** from anywhere.  
   - EC2 allows **SSH only from a specific IP** (your IP).  
   - RDS allows **MySQL (port 3306) only from the EC2 instance**.

3. **Load Balancer & Web Server**  
   - A **public-facing ALB** routes traffic to an **EC2 instance** running **Nginx**.  
   - Nginx serves a simple web page with **"Hello, World!"**.

4. **RDS Database**  
   - A **MySQL instance** in private subnets.  
   - Only accessible from the **EC2 instance’s security group**.

---

## Folder Structure

```
.
├── main
│   ├── providers.tf
│   ├── datasources.tf
│   ├── main.tf
│   ├── variables.tf
│   ├── terraform.tfvars
│   └── README.md
└── modules
    ├── vpc
    │   ├── main.tf
    │   ├── outputs.tf
    │   └── variables.tf
    ├── ec2
    │   ├── main.tf
    │   ├── outputs.tf
    │   └── variables.tf
    ├── loadbalancer
    │   ├── main.tf
    │   ├── outputs.tf
    │   └── variables.tf
    └── database
        ├── main.tf
        ├── outputs.tf
        └── variables.tf
```

---

## Prerequisites

Ensure you have the following installed on your local machine:

- **Terraform** (v1.0+ recommended)
- **AWS CLI** (configured with credentials)
- **An AWS account** with necessary permissions

---

## Setup Instructions

### 1. **Clone the Repository**
```
git clone <repository-url>
cd <project-directory>
```

### 2. **Initialize Terraform**
```
terraform init
```

### 3. **Configure Variables**
Edit `terraform.tfvars` in the `main/` directory to match your environment:

```
app_name         = "myapp"
environment_name = "dev"

vpc_cidr = "10.1.0.0/16"

subnets_public = {
  public_subnet1 = { cidr = "10.1.1.0/24" },
  public_subnet2 = { cidr = "10.1.2.0/24" }
}

subnets_private = {
  private_subnet1 = { cidr = "10.1.3.0/24" },
  private_subnet2 = { cidr = "10.1.4.0/24" }
}

instance_config = {
  ami_id        = "ami-xxxxxxxxxxxxxxxxx"
  instance_type = "t2.micro"
}

ssh_ingress_rules = [
  {
    description = "Allow SSH from my IP"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["YOUR.IP.ADDR/32"]
  }
]

db_properties = {
  allocated_storage   = 20
  instance_class      = "db.t3.micro"
  engine              = "mysql"
  username            = "dbadmin"
  password            = "SecurePassword123!"
  skip_final_snapshot = true
}

public_access = false
```

Replace `"YOUR.IP.ADDR/32"` with your actual **public IP**.

---

## Deployment

### **1. Plan the Infrastructure**
```
terraform plan
```

This will show you what Terraform is about to create.

### **2. Apply the Changes**
```
terraform apply
```

Confirm with `yes`. Terraform will provision the AWS resources.

---

## Accessing the Deployed Services

### **1. Get the Load Balancer DNS Name**
Run:
```
terraform output -raw alb_dns_name
```

It should return a URL like:
```
myapp-dev-alb-1234567890.us-east-1.elb.amazonaws.com
```

Open this URL in your browser. You should see:

```
Hello, World!
```

### **2. SSH into the EC2 Instance**
Run:
```
ssh -i path/to/your/private-key.pem ubuntu@<EC2_PUBLIC_IP>
```

Replace `<EC2_PUBLIC_IP>` with the actual public IP of the EC2 instance.

---

## Cleanup

To destroy all resources:
```
terraform destroy
```

This will **delete** the VPC, subnets, security groups, ALB, EC2 instance, and RDS instance.

