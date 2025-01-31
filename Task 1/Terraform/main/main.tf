module "vpc" {
  source                     = "../modules/vpc"
  vpc_cidr                   = var.vpc_cidr
  subnets_public             = var.subnets_public
  subnets_private            = var.subnets_private
  availability_zones         = data.aws_availability_zones.available.names
  app_name                   = var.app_name
  environment_name           = var.environment_name
}

module "loadbalancer" {
  source             = "../modules/loadbalancer"
  vpc_id             = module.vpc.vpc_id
  subnet_public      = module.vpc.public_subnet_ids
  lb_ingress_rules   = var.lb_ingress_rules
  lb_egress_rules    = var.lb_egress_rules
  app_name           = var.app_name
  environment_name   = var.environment_name

  ec2_instance_id = module.ec2.instance_id
}


module "ec2" {
  source           = "../modules/ec2"
  app_name         = var.app_name
  environment_name = var.environment_name
  instance_config  = var.instance_config
  public_subnets   = module.vpc.public_subnet_ids
  lb_security_group_id = module.loadbalancer.lb_security_group_id
  ssh_ingress_rules    = var.ssh_ingress_rules
}

module "database" {
  source           = "../modules/database"
  app_name         = var.app_name
  environment_name = var.environment_name
  db_properties    = var.db_properties
  subnet_ids       = module.vpc.private_subnet_ids
  vpc_id           = module.vpc.vpc_id
  ec2_sg_id        = module.ec2.instance_sg_id
  public_access    = var.public_access 
}
