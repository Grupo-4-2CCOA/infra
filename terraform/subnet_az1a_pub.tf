resource "aws_subnet" "grupo4_subnet_az1a_pub" {
  vpc_id = aws_vpc.grupo4_vpc.id  
  cidr_block = "10.1.0.0/28"
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "grupo4-subnet-az1a-pub"
  }
}
