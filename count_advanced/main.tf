provider "aws" {
  region = "eu-west-2"
}

module "db_module" {
  source = "./db_server"
  server_names = ["test", "prod"]
}

output "private_ips" {
  value = module.db_module.db_server_private_ip
}