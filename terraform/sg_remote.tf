resource "aws_security_group" "grupo4_sg_remote" {
  vpc_id = aws_vpc.grupo4_vpc.id
  name = "grupo4_sg_remote"
  description = "SSH:22;RDP:3389"

  ingress {
    protocol = "tcp"
    from_port = 22
    to_port = 22
    cidr_blocks = ["0.0.0.0/0"]
    description = "SSH:22"
  }

  ingress {
    protocol = "tcp"
    from_port = 3389
    to_port = 3389
    cidr_blocks = ["0.0.0.0/0"]
    description = "RDP:3389"
  }

  ingress {
    protocol = "tcp"
    from_port = 3000
    to_port = 3000
    cidr_blocks = ["0.0.0.0/0"]
    description = "Grafana:3000"
  }

  egress {
    protocol = "-1"
    from_port = 0
    to_port = 0
    cidr_blocks = ["0.0.0.0/0"]
    description = "ALL:-1"
  }

  tags = {
    Name = "grupo4-sg-remote"
  }
}
