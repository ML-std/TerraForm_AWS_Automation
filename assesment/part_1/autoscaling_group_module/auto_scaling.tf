
variable "vpc_id" {
  type = string
}
variable "subnet_ids" {
  type = list(string)
}
variable "min_size" {
  type = number
  default = 2
}
variable "max_size" {
  type = number
  default = 2
}
variable "desired_capacity" {
  type = number
  default = 2
}

variable "security_groups" {
  type = list(string)
}


resource "aws_launch_template" "terraform_assesment_template" {
  name_prefix = "terraform"
  image_id = "ami-09d6bbc1af02c2ca1" 
  instance_type = "t2.micro"
  user_data = filebase64("${path.module}/welcome_script.sh")
  vpc_security_group_ids = var.security_groups
}

resource "aws_autoscaling_group" "terraform_assesment_autoscaling_group" {
  name = "terraform_assesment-asg"
  
  min_size = var.min_size
  max_size = var.max_size
  desired_capacity = var.desired_capacity

  launch_template {
    id = aws_launch_template.terraform_assesment_template.id
    version = "$Latest"
  }
  vpc_zone_identifier = var.subnet_ids

}
