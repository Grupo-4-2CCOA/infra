resource "aws_nat_gateway" "grupo4_nat_gateway_az1a" {
    allocation_id = aws_eip.grupo4_eip_az1a.id
    subnet_id     = aws_subnet.grupo4_subnet_az1a_pub.id
    tags = {
        Name = "grupo4-nat-gateway-az1a"
    }
}
