resource "aws_instance" "grupo4_ec2_az1a_pri_0" {
  ami                         = var.ec2_ami
  instance_type               = "t2.micro"
  associate_public_ip_address = false
  private_ip                 = "10.1.0.36"

  key_name = aws_key_pair.grupo4_key_pri.key_name

  subnet_id = aws_subnet.grupo4_subnet_az1a_pri.id

  vpc_security_group_ids = [
    aws_security_group.grupo4_sg_private.id
  ]

  ebs_block_device {
    device_name = "/dev/sda1"
    volume_type = "gp3"
    volume_size = 8

    tags = {
      Name = "grupo4-ebs-default-ec2-az1a-pri-0"
    }
  }

  user_data = join("\n\n", [
    "#!/bin/bash",
    file("${path.module}/files/shell/installing_docker.sh"),
    templatefile("${path.module}/files/shell/installing_java.sh", {
      arquivo_docker_compose = base64encode(file("${path.module}/files/scripts/compose-private.yaml"))
    })
  ])

  tags = {
    Name = "grupo4-ec2-az1a-pri-0"
  }
}

resource "aws_ec2_tag" "grupo4_ec2_az1a_pri_0_eni_name" {
  resource_id = aws_instance.grupo4_ec2_az1a_pri_0.primary_network_interface_id

  key   = "Name"
  value = "grupo4-eni-ec2-az1a-pri-0"
}
