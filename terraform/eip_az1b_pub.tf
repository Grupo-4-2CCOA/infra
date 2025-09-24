resource "aws_eip" "eip_az1b_pub" {
  tags = {
    Name = "eip-az1b-pub"
  }
}

resource "aws_eip_association" "eip_association_az1b_pub" {
  instance_id = aws_instance.grupo4_ec2_az1b_pub_0.id
  allocation_id = aws_eip.eip_az1b_pub.id
}