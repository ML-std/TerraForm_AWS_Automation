provider "aws" {
  region = "eu-west-2"
}
resource "aws_instance" "db-server" {
  ami = "ami-09d6bbc1af02c2ca1"
  instance_type = "t2.micro"
  security_groups = [ aws_security_group.webtraffic.name ]
  tags = {
    Name = "DB Server"
  }
}

resource "aws_instance" "web-server" {
  ami = "ami-09d6bbc1af02c2ca1"
  instance_type = "t2.micro"
  security_groups = [ aws_security_group.webtraffic.name ]
  tags = {
    Name = "Web Server"
  }  
  user_data = file("script.sh")
}

resource "aws_eip" "web-server-eip" {
    instance = aws_instance.web-server.id
}

resource "aws_security_group" "webtraffic" {
  name = "Allow HTTPS and HTTP"
  dynamic "ingress" {
    iterator = port
    for_each = var.ingressrules
    content {
      from_port = port.value
      to_port = port.value
      protocol = "TCP"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
    dynamic "egress" {
    iterator = port
    for_each = var.egressrules
    content {
      from_port = port.value
      to_port = port.value
      protocol = "TCP"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
}

variable "ingressrules" {
  type = list(number)
  default = [ 80,443 ]
}
variable "egressrules" {
  type = list(number)
  default = [ 80, 443]
}

output "DB_Server_Private_IP" {
  value = aws_instance.db-server.private_ip
}

output "Web_Server_EIP" {
  value = aws_eip.web-server-eip.public_ip
}