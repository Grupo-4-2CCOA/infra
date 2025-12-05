resource "aws_instance" "grupo4_ec2_az1a_db_0" {
  ami = var.ec2_ami
  instance_type = "t2.medium"
  associate_public_ip_address = false
  private_ip = var.private_database_api_ip

  key_name = aws_key_pair.grupo4_key_db.key_name

  subnet_id = aws_subnet.grupo4_subnet_az1a_pri.id

  vpc_security_group_ids = [
    aws_security_group.grupo4_sg_private.id
  ]

  ebs_block_device {
    device_name = "/dev/sda1"
    volume_type = "gp3"
    volume_size = 24

    tags = {
      Name = "grupo4-ebs-default-ec2-az1a-db"
    }
  }

  connection {
    type = "ssh"
    user = var.instance_user
    host = aws_instance.grupo4_ec2_az1a_db_0.private_ip
    private_key = tls_private_key.grupo4_key_db.private_key_pem
    bastion_host = var.public_ip
    bastion_user = var.instance_user
    bastion_private_key = tls_private_key.grupo4_key_pub.private_key_pem
  }
  
  provisioner "file" {
    source      = "files/shell/backup_database.sh"
    destination = "/home/ubuntu/backup.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /home/ubuntu/backup.sh",
      "(crontab -l 2>/dev/null; echo \"0 15 * * * sh /home/ubuntu/backup.sh > /home/ubuntu/backup_cron.log 2>&1\") | crontab -"
    ]
  }

  user_data = join("\n\n", [
    "#!/bin/bash",
    file("${path.module}/files/shell/installing_docker.sh"),
    templatefile("${path.module}/files/shell/installing_mysql.sh", {
      arquivo_docker_compose = base64encode(file("${path.module}/files/scripts/compose-mysql.yaml"))
    })
  ])

  tags = {
    Name = "grupo4-ec2-az1a-db-0"
  }
}

resource "aws_ec2_tag" "grupo4_ec2_az1a_db_eni_name" {
  resource_id = aws_instance.grupo4_ec2_az1a_db_0.primary_network_interface_id

  key = "Name"
  value = "grupo4-eni-ec2-az1a-db-0"
}
