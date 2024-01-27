provider "aws" {
  region = "eu-west-2"
}

module "ec2" {
  source = "./ec2"
  ec2name = "Ec2 name from Module"
}

output "module_output" {
  value = module.ec2.instance_id
}