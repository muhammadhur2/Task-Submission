output "instance_id" {
  value = aws_instance.ec2.id
}

output "instance_sg_id" {
  value = aws_security_group.ec2_sg.id
}
