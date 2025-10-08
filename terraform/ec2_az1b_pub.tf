resource "aws_instance" "grupo4_ec2_az1b_pub_0" {
  ami = var.ec2_ami
  instance_type = "t2.micro"

  key_name = "grupo4-key-pub"

  subnet_id = aws_subnet.grupo4_subnet_az1b_pub.id

  vpc_security_group_ids = [
    aws_security_group.grupo4_sg_remote.id,
    aws_security_group.grupo4_sg_web.id,
    aws_security_group.grupo4_sg_efs.id
  ]

  ebs_block_device {
    device_name = "/dev/sda1"
    volume_type = "gp3"
    volume_size = 8

    tags = {
      Name = "grupo4-ebs-default-ec2-az1b-pub-0"
    }
  }

  user_data = file("/files/shell/ec2_pub.sh")

  tags = {
    Name = "grupo4-ec2-az1b-pub-0"
  }
}
resource "aws_ec2_tag" "grupo4_ec2_az1b_pub_0_eni_name" {
  resource_id = aws_instance.grupo4_ec2_az1b_pub_0.primary_network_interface_id

  key = "Name"
  value = "grupo4-eni-ec2-az1b-pub-0"
}
