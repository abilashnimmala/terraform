variable "instance_type" {
  default = "t2.medium"
}

variable "cidr_block" {
  default = "172.16.0.0/16" # VPC range
}

variable "subnet_cidr_block" {
  default = "172.16.10.0/24" # Subnet inside VPC range
}

variable "private_ips" {
  default = "172.16.10.100"
}

variable "vpn_ip" {
  # Replace with your real IP/CIDR block. /32 means single IP.
  default = "204.1.133.25/32"
}


