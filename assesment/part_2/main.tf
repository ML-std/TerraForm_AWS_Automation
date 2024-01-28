provider "aws" {
  region = "eu-west-2"
}

variable "connection_ip" {
  type = string
}

variable "cluster_name" {
  type = string
}

variable "cluster_version" {
  type = string
}

module "vpc" {
  source = "./vpc_module"
}

module "eks_cluster" {
  source = "./eks_module"
  cluster_name = var.cluster_name
  subnet_ids = module.vpc.public_subnet_ids
  vpc_id = module.vpc.vpc_id
  cluster_version = var.cluster_version
}

output "public_subnet_ids" {
  value = module.vpc.public_subnet_ids
}

output "cluster_name" {
  value = var.cluster_name
}