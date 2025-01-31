resource "aws_security_group" "ec2_sg" {
  name   = "${var.app_name}-${var.environment_name}-ec2-sg"
  vpc_id = var.vpc_id

  # SSH from a specific IP (passed via var.ssh_ingress_rules)
  dynamic "ingress" {
    for_each = var.ssh_ingress_rules
    content {
      description = ingress.value.description
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
    }
  }

  # ALLOW inbound HTTP from LB SG ONLY:
  # We'll add a referencing rule by security_group_id in a separate block
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.app_name}-${var.environment_name}-ec2-sg"
  }
}

# Add inbound rule to allow HTTP from the LB's SG
resource "aws_security_group_rule" "allow_http_from_lb" {
  type                     = "ingress"
  security_group_id        = aws_security_group.ec2_sg.id
  from_port                = 80
  to_port                  = 80
  protocol                 = "tcp"
  source_security_group_id = var.lb_security_group_id
  description              = "Allow HTTP from LB"
}

resource "aws_instance" "ec2" {
  ami           = var.instance_config.ami_id
  instance_type = var.instance_config.instance_type
  subnet_id     = var.public_subnets[0]   # first public subnet
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]

  user_data = <<-EOT
    #!/bin/bash
    apt-get update -y
    apt-get install -y nginx
    systemctl enable nginx
    systemctl start nginx
    echo "<h1>Hello, World!</h1>" > /var/www/html/index.html
  EOT

  tags = {
    Name = "${var.app_name}-${var.environment_name}-ec2"
  }
}
