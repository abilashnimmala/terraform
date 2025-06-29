resource "aws_instance" "abhi" {
  ami           = "ami-05ffe3c48a9991133"
  instance_type = "t2.micro"

  tags = {
    Name = "Abilashnimmala"
  }
}

resource "aws_eip" "abhi" {
  domain = "vpc"
}

resource "aws_eip_association" "eip_assoc" {
  instance_id   = aws_instance.abhi.id
  allocation_id = aws_eip.abhi.id
}
