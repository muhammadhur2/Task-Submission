resource "aws_security_group" "db_sg" {
  name   = "${var.app_name}-${var.environment_name}-db-sg"
  vpc_id = var.vpc_id

  ingress {
    description            = "Allow MySQL from EC2"
    from_port              = 3306
    to_port                = 3306
    protocol               = "tcp"
    security_groups        = [var.ec2_sg_id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.app_name}-${var.environment_name}-db-sg"
  }
}

resource "aws_db_subnet_group" "db_subnet_group" {
  name       = "${var.app_name}-${var.environment_name}-db-subnet-group"
  subnet_ids = var.subnet_ids

  tags = {
    Name = "${var.app_name}-${var.environment_name}-db-subnet-group"
  }
}

resource "aws_db_instance" "db" {
  allocated_storage      = var.db_properties.allocated_storage
  engine                 = var.db_properties.engine
  instance_class         = var.db_properties.instance_class
  username               = var.db_properties.username
  password               = var.db_properties.password
  skip_final_snapshot    = var.db_properties.skip_final_snapshot
  db_subnet_group_name   = aws_db_subnet_group.db_subnet_group.name
  vpc_security_group_ids = [aws_security_group.db_sg.id]
  publicly_accessible    = var.public_access

  # We'll name the DB, if you want:
  db_name     = "${var.app_name}${var.environment_name}db"

  tags = {
    Name = "${var.app_name}-${var.environment_name}-rds"
  }
}
