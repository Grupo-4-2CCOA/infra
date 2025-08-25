resource "aws_internet_gateway" "grupo4_igw" {
  vpc_id = aws_vpc.grupo4_vpc.id

  tags = {
    Name = "grupo4-igw"
  }
}
