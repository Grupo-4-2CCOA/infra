resource "aws_instance" "grupo4_ec2_az1a_db" {
  ami = "ami-0360c520857e3138f"
  instance_type = "t2.micro"

  key_name = aws_key_pair.grupo4_key_db.key_name

  subnet_id = aws_subnet.grupo4_subnet_az1a_pri.id

  vpc_security_group_ids = [
    aws_security_group.grupo4_sg_remote.id,
    aws_security_group.grupo4_sg_mysql.id
  ]

  ebs_block_device {
    device_name = "/dev/sda1"
    volume_type = "gp3"
    volume_size = 24
  }

  tags = {
    Name = "grupo4-ec2-az1a-db"
  }
}
