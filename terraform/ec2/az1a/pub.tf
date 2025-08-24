resource "aws_instance" "grupo4_ec2_az1a_pub_0" {
  subnet_id = aws_subnet.grupo4_subnet_az1a_pub.id
  ami = "ami-0360c520857e3138f"
  instance_type = "t2.micro"

  tags = {
    Name = "grupo4-ec2-az1a-publica-0"
  }
}
