resource "aws_default_route_table" "grupo4_default_rtb" {
  default_route_table_id = aws_vpc.grupo4_vpc.default_route_table_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.grupo4_igw.id
  }

  tags = {
    Name = "grupo4-rtb-default"
  }
}
