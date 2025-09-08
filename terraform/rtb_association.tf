resource "aws_route_table_association" "grupo4_rtb_association_az1a_pub" {
  subnet_id      = aws_subnet.grupo4_subnet_az1a_pub.id
  route_table_id = aws_route_table.grupo4_rtb.id
}
