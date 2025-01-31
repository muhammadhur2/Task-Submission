variable "app_name" {
  type = string
}

variable "environment_name" {
  type = string
}

variable "db_properties" {
  type = object({
    allocated_storage   = number
    instance_class      = string
    engine              = string
    username            = string
    password            = string
    skip_final_snapshot = bool
  })
}

variable "subnet_ids" {
  type        = list(string)
  description = "Private subnet IDs for the DB"
}

variable "vpc_id" {
  type = string
}

variable "ec2_sg_id" {
  type        = string
  description = "Security Group of the EC2 instance to allow MySQL inbound"
}

variable "public_access" {
  type    = bool
  default = false
}
