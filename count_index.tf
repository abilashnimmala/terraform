variable "server" {
    type = list
    default = ["dev","qa","stage","prod"]
}

resource "aws_instance" "web" {
  ami           = "ami-05ffe3c48a9991133"
  instance_type = "t3.micro"
  count = 4
  tags = {
    Name = var.server[count.index]
  }
}

