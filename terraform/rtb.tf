resource "aws_route_table" "grupo4_rtb" {
  vpc_id = aws_vpc.grupo4_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.grupo4_igw.id
  }

  tags = {
    Name = "grupo4-rtb"
  }
}
