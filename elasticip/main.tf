provider "aws" {
  region = "eu-west-2"
}
resource "aws_instance" "ec2" {
  ami = "ami-09d6bbc1af02c2ca1"
  instance_type = "t2.micro"
}

output "ec2_id" {
  value = aws_instance.ec2.id
}

resource "aws_eip" "aws_eip" {
  instance = aws_instance.ec2.id
}

output "EIP_PUBLIC_IP" {
  value = aws_eip.aws_eip.public_ip
}