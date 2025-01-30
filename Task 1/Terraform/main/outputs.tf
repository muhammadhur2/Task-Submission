output "vpc_id" {
  description = "The ID of the created VPC"
  value       = module.vpc.vpc_id
}

output "public_subnets" {
  description = "IDs of public subnets"
  value       = module.vpc.public_subnets
}

output "private_subnets" {
  description = "IDs of private subnets"
  value       = module.vpc.private_subnets
}

output "db_subnets" {
  description = "IDs of DB subnets"
  value       = module.vpc.db_subnets
}

output "alb_dns_name" {
  description = "DNS name of the load balancer"
  value       = module.lb.alb_dns_name
}

output "ec2_public_ip" {
  description = "Public IP of the created EC2 instance"
  value       = module.ec2.ec2_public_ip
}

output "rds_endpoint" {
  description = "Endpoint for the RDS instance"
  value       = module.rds.rds_endpoint
}
