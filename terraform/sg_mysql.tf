resource "aws_security_group" "grupo4_sg_mysql" {
  vpc_id = aws_vpc.grupo4_vpc.id
  name = "grupo4_sg_mysql"
  description = "MySQL:3306"

  ingress {
    protocol = "tcp"
    from_port = 3306
    to_port = 3306
    cidr_blocks = ["10.1.0.32/28"]
    description = "MySQL:3306"
  }

  egress {
    protocol = "-1"
    from_port = 0
    to_port = 0
    cidr_blocks = ["10.1.0.32/28"]
    description = "ALL:-1"
  }

  tags = {
    Name = "grupo4-sg-mysql"
  }
}
