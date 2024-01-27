provider "aws" {
  region = "eu-west-2"
}
resource "aws_instance" "db" {
  ami = "ami-09d6bbc1af02c2ca1"
  instance_type = "t2.micro"
  tags = {
    Name = "DB Server"
  }  
}

resource "aws_instance" "web" {
  ami = "ami-09d6bbc1af02c2ca1"
  instance_type = "t2.micro"
  depends_on = [ aws_instance.db ]
  tags = {
    Name = "Web Server"
  }
}

output "ec2_id" {
  value = aws_instance.web.id
}

data "aws_instance" "dbsearch" {
  filter {
    name = "tag:Name"
    values = ["DB Server"]
  }
}

output "dbservers" {
  value = [data.aws_instance.dbsearch.availability_zone]
}