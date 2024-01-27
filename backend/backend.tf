terraform {
  backend "s3" {
      key = "terraform/tfstate.tfstate"
      bucket = "terraform-learning-bucket-007"
      region = "eu-west-2"
  }
}