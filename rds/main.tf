provider "aws" {
  region = "eu-west-2"
}

resource "aws_db_instance" "terraformRDS" {
    identifier = "test-rds"
    db_name = "terraformDB"
    instance_class = "db.t2.micro"
    engine = "mariadb"
    engine_version = "10.6.14"
    username = "terraformrds"
    password = "terraformpass"
    port = 3306
    allocated_storage = 20
    skip_final_snapshot = true
}