resource "aws_instance" "grupo4_ec2_az1c_pub_0" {
  ami = var.ec2_ami
  instance_type = "t2.micro"

  key_name = aws_key_pair.grupo4_key_pub.key_name

  subnet_id = aws_subnet.grupo4_subnet_az1c_pub.id

  vpc_security_group_ids = [
    aws_security_group.grupo4_sg_remote.id
  ]

  iam_instance_profile = "LabInstanceProfile"

  ebs_block_device {
    device_name = "/dev/sda1"
    volume_type = "gp3"
    volume_size = 8

    tags = {
      Name = "grupo4-ebs-default-ec2-az1c-pub-0"
    }
  }

  user_data = join("\n\n", [
    "#!/bin/bash",
    file("${path.module}/files/shell/installing_grafana.sh")
  ])

  tags = {
    Name = "grupo4-ec2-az1c-pub-0"
  }
}

resource "aws_ec2_tag" "grupo4_ec2_az1c_pub_0_eni_name" {
  resource_id = aws_instance.grupo4_ec2_az1c_pub_0.primary_network_interface_id

  key = "Name"
  value = "grupo4-eni-ec2-az1c-pub-0"
}
