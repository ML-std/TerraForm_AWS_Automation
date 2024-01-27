provider "aws" {
  region = "eu-west-2"
}

resource "aws_vpc" "terraform_learning" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_default_vpc" "default" {
  tags = {
    Name = "Default VPC"
  }
}