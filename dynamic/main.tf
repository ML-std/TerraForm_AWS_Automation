provider "aws" {
  region = "eu-west-2"
}
resource "aws_instance" "ec2" {
  ami = "ami-09d6bbc1af02c2ca1"
  instance_type = "t2.micro"
  security_groups = [ aws_security_group.webtraffic.name ]
}

resource "aws_security_group" "webtraffic" {
  name = "Allow HTTPS"
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
  default = [ 80,443, 8080, 8443 ]
}
