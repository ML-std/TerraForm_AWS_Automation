variable "security_group_name" {
  type = string
}

resource "aws_instance" "web_ec2" {
  ami = "ami-09d6bbc1af02c2ca1"
  instance_type = "t2.micro"
  tags = {
    Name = "Web Server"
  }
  user_data = file("./web_server/script.sh")
  security_groups = [var.security_group_name]
}

output "Web_server_id" {
  value = aws_instance.web_ec2.id
}

