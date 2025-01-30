app_name         = "google"
environment_name = "terraform"

vpc_cidr = "10.1.0.0/16"

# 2 Public subnets across 2 AZs
subnets_public = {
  public_subnet1 = { cidr = "10.1.1.0/24" },
  public_subnet2 = { cidr = "10.1.2.0/24" }
}

# 2 Private subnets across 2 AZs (for RDS)
subnets_private = {
  private_subnet1 = { cidr = "10.1.3.0/24" },
  private_subnet2 = { cidr = "10.1.4.0/24" }
}

# EC2 instance config
instance_config = {
  ami_id        = "ami-0173ee29ff797c346"
  instance_type = "t2.micro"
}

# Restrict SSH to your IP
ssh_ingress_rules = [
  {
    description = "SSH from my IP"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["175.107.202.231/32"]
  }
]

# ALB SG inbound: HTTP/HTTPS from anywhere
lb_ingress_rules = [
  {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  },
  {
    description = "HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
]

# ALB SG outbound: all
lb_egress_rules = [
  {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
]

db_properties = {
  allocated_storage   = 20
  instance_class      = "db.t3.micro"
  engine              = "mysql"
  username            = "terraformdbadmin"
  password            = "Rahnumadb123!"
  skip_final_snapshot = true
}

public_access = false
