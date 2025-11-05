resource "aws_eip_association" "eip_association_az1c_pub" {
  instance_id = aws_instance.grupo4_ec2_az1c_pub_0.id
  allocation_id = var.elastic_ip_az1c_id
}