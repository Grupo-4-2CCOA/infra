resource "aws_security_group" "grupo4_sg_efs" {
  vpc_id = aws_vpc.grupo4_vpc.id
  name = "grupo4_sg_efs"
  description = "NFS:2049"

  ingress {
    protocol = "tcp"
    from_port = 3306
    to_port = 3306
    cidr_blocks = ["10.1.0.0/27"]
    description = "NFS:2049"
  }

  tags = {
    Name = "grupo4-sg-efs"
  }
}
