resource "aws_vpc" "grupo4_vpc" {
  cidr_block = "10.1.0.0/26"
  enable_dns_support = true
  enable_dns_hostnames = true

  tags = {
    Name = "grupo4-vpc"
  }
}
