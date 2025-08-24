resource "aws_subnet" "grupo4_subnet_az1a_pub" {
  vpc_id = aws_vpc.grupo4_vpc.id
  availability_zone = "az1a"
}
