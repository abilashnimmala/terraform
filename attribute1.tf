# ------------------------------------------------------------------------------
# SUMMARY:
# This Terraform configuration:
# - Launches an EC2 instance.
# - Allocates and associates an Elastic IP (EIP) with the instance.
# - Creates a security group that whitelists the instance's own EIP.
#     - Ingress: Allows HTTPS (port 443) only from the EIP (optional).
#     - Egress: Allows all outbound traffic only to the EIP (rare use case).
# ------------------------------------------------------------------------------

# Use default VPC
data "aws_vpc" "default" {
  default = true
}

# EC2 Instance
resource "aws_instance" "abhi" {
  ami           = "ami-05ffe3c48a9991133"
  instance_type = "t2.micro"

  vpc_security_group_ids = [aws_security_group.allow_tls.id]

  tags = {
    Name = "Abilashnimmala"
  }
}

# Elastic IP
resource "aws_eip" "abhi" {
  domain = "vpc"
}

# Associate EIP with EC2
resource "aws_eip_association" "eip_assoc" {
  instance_id   = aws_instance.abhi.id
  allocation_id = aws_eip.abhi.id
}

# Security Group that whitelists EIP
resource "aws_security_group" "allow_tls" {
  name        = "allow_tls"
  description = "Allow TLS and restrict outbound to EIP"
  vpc_id      = data.aws_vpc.default.id

  # Optional Ingress: HTTPS access only from this EIP
  ingress {
    description = "Allow HTTPS from EIP"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["${aws_eip.abhi.public_ip}/32"]
  }

  tags = {
    Name = "allow_tls"
  }
}

# Egress Rule: Allow all traffic only to the EIP
resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.allow_tls.id
  cidr_ipv4         = "${aws_eip.abhi.public_ip}/32"
  ip_protocol       = "-1"
}

