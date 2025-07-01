resource "aws_vpc" "my_vpc" {
  cidr_block = var.cidr_block

  tags = {
    Name = "tf-example"
  }
}

resource "aws_subnet" "my_subnet" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = var.subnet_cidr_block
  availability_zone = "us-east-1a"

  tags = {
    Name = "tf-example-subnet"
  }
}

resource "aws_security_group" "my_sg" {
  name        = "my-sec-group"
  description = "Allow custom ports"
  vpc_id      = aws_vpc.my_vpc.id

  ingress {
    description = "Allow Custom HTTPS (4431)"
    from_port   = 4431
    to_port     = 4431
    protocol    = "tcp"
    cidr_blocks = [var.vpn_ip]
  }

  ingress {
    description = "Allow HTTP (80)"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [var.vpn_ip]
  }

  ingress {
    description = "Allow DNS (53)"
    from_port   = 53
    to_port     = 53
    protocol    = "tcp"
    cidr_blocks = [var.vpn_ip]
  }

  ingress {
    description = "Allow FTP (21)"
    from_port   = 21
    to_port     = 21
    protocol    = "tcp"
    cidr_blocks = [var.vpn_ip]
  }

  ingress {
    description = "Allow SSH (22)"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.vpn_ip]
  }

  ingress {
    description = "Allow Telnet (23)"
    from_port   = 23
    to_port     = 23
    protocol    = "tcp"
    cidr_blocks = [var.vpn_ip]
  }

  ingress {
    description = "Allow SMTP (25)"
    from_port   = 25
    to_port     = 25
    protocol    = "tcp"
    cidr_blocks = [var.vpn_ip]
  }

  ingress {
    description = "Allow DHCP (67)"
    from_port   = 67
    to_port     = 67
    protocol    = "udp"
    cidr_blocks = [var.vpn_ip]
  }

  ingress {
    description = "Allow POP3 (110)"
    from_port   = 110
    to_port     = 110
    protocol    = "tcp"
    cidr_blocks = [var.vpn_ip]
  }

  ingress {
    description = "Allow NTP (123)"
    from_port   = 123
    to_port     = 123
    protocol    = "udp"
    cidr_blocks = [var.vpn_ip]
  }

  ingress {
    description = "Allow IMAP (143)"
    from_port   = 143
    to_port     = 143
    protocol    = "tcp"
    cidr_blocks = [var.vpn_ip]
  }

  ingress {
    description = "Allow SNMP (161)"
    from_port   = 161
    to_port     = 161
    protocol    = "udp"
    cidr_blocks = [var.vpn_ip]
  }

  ingress {
    description = "Allow LDAP (389)"
    from_port   = 389
    to_port     = 389
    protocol    = "tcp"
    cidr_blocks = [var.vpn_ip]
  }

  ingress {
    description = "Allow HTTPS (443)"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [var.vpn_ip]
  }

  ingress {
    description = "Allow SMTPS (465)"
    from_port   = 465
    to_port     = 465
    protocol    = "tcp"
    cidr_blocks = [var.vpn_ip]
  }

  ingress {
    description = "Allow Syslog (514)"
    from_port   = 514
    to_port     = 514
    protocol    = "udp"
    cidr_blocks = [var.vpn_ip]
  }

  ingress {
    description = "Allow Submission (587)"
    from_port   = 587
    to_port     = 587
    protocol    = "tcp"
    cidr_blocks = [var.vpn_ip]
  }

  ingress {
    description = "Allow IMAPS (993)"
    from_port   = 993
    to_port     = 993
    protocol    = "tcp"
    cidr_blocks = [var.vpn_ip]
  }

  ingress {
    description = "Allow POP3S (995)"
    from_port   = 995
    to_port     = 995
    protocol    = "tcp"
    cidr_blocks = [var.vpn_ip]
  }

  ingress {
    description = "Allow MySQL (3306)"
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = [var.vpn_ip]
  }

  ingress {
    description = "Allow HTTP Alt (8080)"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = [var.vpn_ip]
  }

  ingress {
    description = "Allow HTTPS Alt (8443)"
    from_port   = 8443
    to_port     = 8443
    protocol    = "tcp"
    cidr_blocks = [var.vpn_ip]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "my-security-group"
  }
}

resource "aws_network_interface" "mynetwork" {
  subnet_id       = aws_subnet.my_subnet.id
  private_ips     = [var.private_ips]
  security_groups = [aws_security_group.my_sg.id]

  tags = {
    Name = "primary_network_interface"
  }
}

resource "aws_instance" "myweb" {
  ami           = "ami-090fa75af13c156b4" # ✅ us-east-1 Amazon Linux 2
  instance_type = var.instance_type

  network_interface {
    network_interface_id = aws_network_interface.mynetwork.id
    device_index         = 0
  }

  credit_specification {
    cpu_credits = "unlimited"
  }

  tags = {
    Name = "tf-instance"
  }
}

