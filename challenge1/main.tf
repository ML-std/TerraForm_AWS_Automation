provider "aws" {
  region = "eu-west-2"
}
resource "aws_vpc" "terraformVPC" {
  cidr_block = "192.168.0.0/24"
  tags = {
    Name = "TerraformVPC"
  }
}

output "terraform_vpc_id" {
  value = aws_vpc.terraformVPC.tags.Name
}