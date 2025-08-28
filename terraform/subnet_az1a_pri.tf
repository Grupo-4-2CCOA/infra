resource "aws_subnet" "grupo4_subnet_az1a_pri" {
  vpc_id = aws_vpc.grupo4_vpc.id
  cidr_block = "10.1.0.32/28"
  availability_zone = "us-east-1a"

  tags = {
    Name = "grupo4-subnet-az1a-pri"
  }
}
