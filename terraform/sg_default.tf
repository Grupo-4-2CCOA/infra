resource "aws_default_security_group" "grupo4_sg_default" {
  vpc_id = aws_vpc.grupo4_vpc.id

  tags = {
    Name = "grupo4-sg-default"
  }
}
