variable "istest" {}

resource "aws_instance" "dev" {
  ami           = "ami-05ffe3c48a9991133"
  instance_type = "t3.micro"
  count = var.istest == true ? 1:0
  tags = {
    Name = "dev"
  }
}

resource "aws_instance" "prod" {
  ami           = "ami-05ffe3c48a9991133"
  instance_type = "t3.medium"
  count = var.istest == false ? 1:0
  tags = {
    Name = "prod"
  }
}
