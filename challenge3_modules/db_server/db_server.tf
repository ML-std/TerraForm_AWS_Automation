resource "aws_instance" "db_ec2" {
  ami = "ami-09d6bbc1af02c2ca1"
  instance_type = "t2.micro"
  tags = {
    Name = "DB Server"
  }
}

output "db_server_private_ip" {
  value = aws_instance.db_ec2.private_ip
}