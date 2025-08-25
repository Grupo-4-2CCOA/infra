resource "aws_security_group" "grupo4_sg_web" {
  vpc_id = aws_vpc.grupo4_vpc.id
  name = "grupo4_sg_web"
  description = "HTTPS:443;HTTP:80"

  ingress {
    protocol = "tcp"
    from_port = 443
    to_port = 443
    cidr_blocks = ["0.0.0.0/0"]
    description = "HTTPS:443"
  }
  ingress {
    protocol = "tcp"
    from_port = 80
    to_port = 80
    cidr_blocks = ["0.0.0.0/0"]
    description = "HTTP:80"
  }

  egress {
    protocol = "-1"
    from_port = 0
    to_port = 0
    cidr_blocks = ["0.0.0.0/0"]
    description = "ALL:-1"
  }

  tags = {
    Name = "grupo4-sg-web"
  }
}
