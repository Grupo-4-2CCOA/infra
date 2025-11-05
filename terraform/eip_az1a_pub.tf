resource "aws_eip_association" "eip_association_az1a_pub" {
  instance_id = aws_instance.grupo4_ec2_az1a_pub_0.id
  allocation_id = var.elastic_ip_az1a_id
}