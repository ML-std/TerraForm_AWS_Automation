provider "aws" {
  region = "eu-west-2"
}

module "db_server" {
  source = "./db_server"
}

module "web_server" {
  source = "./web_server"
  security_group_name = module.security_group.security_group_name
}

module "elastic_ip" {
  source = "./elastic_ip"
  web_server_id = module.web_server.Web_server_id
}

module "security_group" {
  source = "./security_group"
}

output "Db_private_ip" {
  value = module.db_server.db_server_private_ip
}

output "Web_Server_public_ip" {
  value = module.elastic_ip.web_eip
}