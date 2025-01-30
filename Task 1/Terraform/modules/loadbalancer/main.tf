resource "aws_security_group" "lb_sg" {
  name   = "${var.app_name}-${var.environment_name}-lb-sg"
  vpc_id = var.vpc_id

  dynamic "ingress" {
    for_each = var.lb_ingress_rules
    content {
      description = ingress.value.description
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
    }
  }

  dynamic "egress" {
    for_each = var.lb_egress_rules
    content {
      from_port   = egress.value.from_port
      to_port     = egress.value.to_port
      protocol    = egress.value.protocol
      cidr_blocks = egress.value.cidr_blocks
    }
  }

  tags = {
    Name = "${var.app_name}-${var.environment_name}-lb-sg"
  }
}

resource "aws_lb" "alb" {
  name               = "${var.app_name}-${var.environment_name}-alb"
  load_balancer_type = "application"
  subnets            = var.subnet_public
  security_groups    = [aws_security_group.lb_sg.id]
  idle_timeout       = 30
  ip_address_type    = "ipv4"

  tags = {
    Name = "${var.app_name}-${var.environment_name}-alb"
  }
}

resource "aws_lb_target_group" "tg" {
  name        = "${var.app_name}-${var.environment_name}-tg"
  port        = 80
  protocol    = "HTTP"
  target_type = "instance"
  vpc_id      = var.vpc_id

  health_check {
    protocol = "HTTP"
    path     = "/"
  }

  tags = {
    Name = "${var.app_name}-${var.environment_name}-tg"
  }
}

resource "aws_lb_listener" "http_listener" {
  load_balancer_arn = aws_lb.alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg.arn
  }
}

# Attach the instance to the Target Group
resource "aws_lb_target_group_attachment" "ec2_attachment" {
  target_group_arn = aws_lb_target_group.tg.arn
  target_id        = var.ec2_instance_id  # Pass from main
  port             = 80
}
