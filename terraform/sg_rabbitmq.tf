resource "aws_security_group" "grupo4_sg_rabbitmq" {
  vpc_id = aws_vpc.grupo4_vpc.id
  name = "grupo4_sg_rabbitmq"
  description = "Permite trafego para RabbitMQ e SSH"

  ingress {
    description = "SSH Access"
    protocol = "tcp"
    from_port = 22
    to_port = 22
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "RabbitMQ"
    protocol = "tcp"
    from_port = 5672
    to_port = 5672
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "RabbitMQ UI"
    protocol = "tcp"
    from_port = 15672
    to_port = 15672
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "grupo4-sg-rabbitmq"
  }
}