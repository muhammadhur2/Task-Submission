variable "app_name" {
  description = "Application name"
  type        = string
}

variable "environment_name" {
  description = "Environment name (e.g., dev, prod)"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR for the VPC"
  type        = string
}

variable "subnets_public" {
  description = "Public subnets (map of AZ => CIDR)"
  type = map(object({
    cidr = string
  }))
}

variable "subnets_private" {
  description = "Private subnets (map of AZ => CIDR)"
  type = map(object({
    cidr = string
  }))
}

variable "instance_config" {
  description = "Configuration for the EC2 instance"
  type = object({
    ami_id        = string
    instance_type = string
  })
}

variable "ssh_ingress_rules" {
  description = "List of objects describing SSH ingress for the EC2 instance"
  type = list(object({
    description = string
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
}

variable "lb_ingress_rules" {
  description = "Load balancer security group ingress rules"
  type = list(object({
    description = string
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
}

variable "lb_egress_rules" {
  description = "Load balancer security group egress rules"
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = list(string)
  }))
}

variable "db_properties" {
  description = "RDS DB configuration"
  type = object({
    allocated_storage   = number
    instance_class      = string
    engine              = string
    username            = string
    password            = string
    skip_final_snapshot = bool
  })
}

variable "public_access" {
  description = "Whether the RDS DB is publicly accessible"
  type        = bool
  default     = false
}
