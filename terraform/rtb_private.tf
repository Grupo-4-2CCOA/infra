resource "aws_route_table" "grupo4_rtb_private" {
    vpc_id = aws_vpc.grupo4_vpc.id

    route {
        cidr_block     = "0.0.0.0/0"
        nat_gateway_id = aws_nat_gateway.grupo4_nat_gateway_az1a.id
    }

    tags = {
        Name = "grupo4-rtb-private"
    }
}

resource "aws_route_table_association" "grupo4_rtb_private_subnet_az1a" {
    subnet_id     = aws_subnet.grupo4_subnet_az1a_pri.id
    route_table_id = aws_route_table.grupo4_rtb_private.id
}