provider "aws" {
  region = "eu-west-2"
}

resource "aws_iam_user" "terraform-user-tf-created" {
  name = "terraform-created-user"

}
resource "aws_iam_policy" "terraform-needed-policy" {
  name = "GlacierEFSEC2"
  policy = file("./policy.json")
}

resource "aws_iam_policy_attachment" "terraform-policy-bind" {
  name = "terraform-policy-attachment"
  users = [ aws_iam_user.terraform-user-tf-created.name ]
  policy_arn = aws_iam_policy.terraform-needed-policy.arn
}