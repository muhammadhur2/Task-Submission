output "alb_dns_name" {
  value = aws_lb.alb.dns_name
}

output "lb_security_group_id" {
  value = aws_security_group.lb_sg.id
}
