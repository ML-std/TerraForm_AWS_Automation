variable "ec2name" {
  type = string
  description = "Ec2 Name"
}
resource "aws_instance" "ec2" {
  ami = "ami-09d6bbc1af02c2ca1"
  instance_type = "t2.micro" 
  tags = {
    Name = var.ec2name
  }
}

output "instance_id" {
  value = aws_instance.ec2.id
}