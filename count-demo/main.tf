provider "aws" {
  region = "eu-west-2"
}

resource "aws_instance" "ec2" {
  ami = "ami-09d6bbc1af02c2ca1"
  instance_type = "t2.micro"
  count = 3
}