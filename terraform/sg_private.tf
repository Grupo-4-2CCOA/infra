resource "aws_security_group" "grupo4_sg_private" {
  vpc_id = aws_vpc.grupo4_vpc.id
  name = "grupo4_sg_private"
  description = "Permite trafego para MySQL, SSH, ALB e servicos internos"

  ingress {
    protocol = "tcp"
    from_port = 80
    to_port = 80
    cidr_blocks = ["0.0.0.0/0"]
    description = "HTTP publico para ALB"
  }

  ingress {
    protocol = "tcp"
    from_port = 22
    to_port = 22
    cidr_blocks = ["0.0.0.0/0"]
    description     = "SSH 22"
  }

  ingress {
    protocol = "tcp"
    from_port = 8080
    to_port = 8080
    cidr_blocks = ["0.0.0.0/0"]
    description  = "Spring Boot API 8080 via ALB (mesmo SG)"
  }

  ingress {
    protocol = "tcp"
    from_port = 3306
    to_port = 3306
    self = true
    description = "MySQL 3306"
  }

  ingress {
    protocol = "tcp"
    from_port = 5672
    to_port = 5672
    security_groups = [aws_security_group.grupo4_sg_web.id]
    description = "RabbitMQ AMQP 5672"
  }

  ingress {
    protocol = "tcp"
    from_port = 15672
    to_port = 15672
    security_groups = [aws_security_group.grupo4_sg_web.id]
    description = "RabbitMQ Management UI 15672"
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
