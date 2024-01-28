provider "aws" {
  region = "eu-west-2"
}

variable "connection_ip" {
  type = string
}

module "vpc" {
  source = "./vpc_module"
}

module "security_group" {
  source  = "./security_group_module"
  vpc_id  = module.vpc.vpc_id
  connection_ip = var.connection_ip  
}

module "autoscaling_group" {
  source       = "./autoscaling_group_module"
  vpc_id       = module.vpc.vpc_id
  subnet_ids   = module.vpc.public_subnet_ids
  security_groups = module.security_group.security_group_name
}

output "public_subnet_ids" {
  value = module.vpc.public_subnet_ids
}