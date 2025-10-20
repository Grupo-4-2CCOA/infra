resource "aws_security_group" "grupo4_sg_private" {
  vpc_id = aws_vpc.grupo4_vpc.id
  name = "grupo4_sg_private"
  description = "Permite trafego para MySQL e App"

  ingress {
    protocol        = "tcp"
    from_port       = 22
    to_port         = 22
    security_groups = [aws_security_group.grupo4_sg_remote.id]
    description     = "SSH 22"
  }

  ingress {
    protocol        = "tcp"
    from_port       = 3333
    to_port         = 3333
    security_groups = [aws_security_group.grupo4_sg_web.id]
    description     = "Web 3333"
  }

  ingress {
    protocol        = "tcp"
    from_port       = 3306
    to_port         = 3306
    security_groups = [aws_security_group.grupo4_sg_web.id]
    description     = "MySQL 3306"
  }

  egress {
    protocol = "-1"
    from_port = 0
    to_port = 0
    cidr_blocks = ["0.0.0.0/0"]
    description = "ALL:-1"
  }

  tags = {
    Name = "grupo4-sg-private"
  }
}
