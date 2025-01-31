variable "app_name" {
  description = "App name"
  type        = string
}

variable "environment_name" {
  description = "Environment name"
  type        = string
}

variable "instance_config" {
  description = "EC2 config"
  type = object({
    ami_id        = string
    instance_type = string
  })
}

variable "public_subnets" {
  type        = list(string)
  description = "IDs of public subnets"
}

variable "vpc_id" {
  type = string
}

variable "ssh_ingress_rules" {
  description = "Rules for SSH from a specific IP"
  type = list(object({
    description = string
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
}

variable "lb_security_group_id" {
  description = "SG ID of the load balancer, so we can allow inbound 80 from LB"
  type        = string
}
