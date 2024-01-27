provider "aws" {
  region = "eu-west-2"
}
variable "vpcname" {
  type = string
  default = "terraform-learning"
}

variable "sshport" {
  type = number
  default = 22
}

variable "enabled" {
  default = true
}

variable "terraform_learning_list" {
  type = list(string)
  default = [ "terraform", "learning" ]
}

variable "terraform_learning_map" {
  type = map
  default = {
    terraform = "easy"
    learning = "fun"
  }
}

variable "inputname" {
  type = string
  description = "Set the name of input"
}

variable "terraform_learning_tuple" {
  type = tuple([string, number, string])
  default = [ "terraform", 3, "fun" ]
}

variable "terraform_learning_object" {
  type = object({
    name = string,
    port = list(number)
  })
  default = {
    name = "terraform_object"
    port = [ 22, 8080, 443 ]
  }
}

resource "aws_vpc" "terraform_learning_input_vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = var.inputname
  }
}

output "terraform_learning_input_vpc_id" {
  value = aws_vpc.terraform_learning_input_vpc.id

}

