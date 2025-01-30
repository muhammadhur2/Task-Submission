variable "app_name" {
  description = "App name"
  type        = string
}

variable "environment_name" {
  description = "Environment name"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "availability_zones" {
  type = list(string)
}

variable "subnets_public" {
  type = map(object({
    cidr = string
  }))
}

variable "subnets_private" {
  type = map(object({
    cidr = string
  }))
}
