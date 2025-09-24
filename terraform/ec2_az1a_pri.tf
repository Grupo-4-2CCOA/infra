resource "aws_instance" "grupo4_ec2_az1a_pri_0" {
  ami = var.ec2_ami
  instance_type = "t2.micro"
  associate_public_ip_address = false

  key_name = aws_key_pair.grupo4_key_pri.key_name

  subnet_id = aws_subnet.grupo4_subnet_az1a_pri.id

  vpc_security_group_ids = [
    aws_security_group.grupo4_sg_remote.id,
    aws_security_group.grupo4_sg_web.id
  ]

  ebs_block_device {
    device_name = "/dev/sda1"
    volume_type = "gp3"
    volume_size = 8
  }

  user_data = file("/files/shell/ec2_pri.sh")

  tags = {
    Name = "grupo4-ec2-az1a-pri-0"
  }
}
