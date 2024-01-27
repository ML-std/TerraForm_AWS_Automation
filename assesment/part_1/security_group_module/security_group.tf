variable "connection_ip" {
  type = string
}
variable "vpc_id" {
  type = string
}

resource "aws_security_group" "allow_connection_ip" {
  name        = "allow_connection_ip"
  description = "Connection IP Rules"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.connection_ip]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [var.connection_ip]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [var.connection_ip]
  }

  egress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

output "security_group_name" {
  value = [aws_security_group.allow_connection_ip.id]
}