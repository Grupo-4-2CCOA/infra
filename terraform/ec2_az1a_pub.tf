resource "aws_instance" "grupo4_ec2_az1a_pub_0" {
  ami = var.ec2_ami
  instance_type = "t2.micro"

  key_name = aws_key_pair.grupo4_key_pub.key_name

  subnet_id = aws_subnet.grupo4_subnet_az1a_pub.id

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
      Name = "grupo4-ebs-default-ec2-az1a-pub-0"
    }
  }

  user_data = join("\n\n", [
    "#!/bin/bash",
    file("${path.module}/files/shell/installing_docker.sh"),
    file("${path.module}/files/shell/installing_nginx.sh")
  ])

  connection {
    type        = "ssh"
    user        = var.instance_user
    private_key = tls_private_key.grupo4_key_pub.private_key_pem
    host        = self.public_ip
  }
  
  provisioner "file" {
    source      = "files/scripts/compose-nginx.yaml"
    destination = "/home/ubuntu/compose.yaml"
  }

  provisioner "file" {
    content = tls_private_key.grupo4_key_pri.private_key_pem
    destination = "/home/ubuntu/instance-key-rest.pem"
  }

  provisioner "file" {
    content = tls_private_key.grupo4_key_db.private_key_pem
    destination = "/home/ubuntu/instance-key-db.pem"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod 400 /home/ubuntu/instance-key-rest.pem",
      "chmod 400 /home/ubuntu/instance-key-db.pem"
    ]
  }

  tags = {
    Name = "grupo4-ec2-az1a-pub-0"
  }
}

resource "aws_ec2_tag" "grupo4_ec2_az1a_pub_0_eni_name" {
  resource_id = aws_instance.grupo4_ec2_az1a_pub_0.primary_network_interface_id

  key = "Name"
  value = "grupo4-eni-ec2-az1a-pub-0"
}
