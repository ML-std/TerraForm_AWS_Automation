variable "web_server_id" {
  type = string
}
resource "aws_eip" "web_eip" {
  instance = var.web_server_id
}

output "web_eip" {
  value = aws_eip.web_eip.public_ip
}