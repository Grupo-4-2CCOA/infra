resource "aws_instance" "grupo4_ec2_az1a_db" {
  ami = var.ec2_ami
  instance_type = "t2.micro"
  associate_public_ip_address = false
  private_ip = "10.1.0.41"

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
    host = aws_instance.grupo4_ec2_az1a_db.private_ip
    private_key = tls_private_key.grupo4_key_db.private_key_pem
    bastion_host = var.public_ip
    bastion_user = var.instance_user
    bastion_private_key = tls_private_key.grupo4_key_pub.private_key_pem
  }
  
  provisioner "file" {
    source      = "files/shell/backup_database.sh"
    destination = "/home/ubuntu/backup.sh"
  }

  provisioner "file" {
    source      = "files/shell/cron_job.sh"
    destination = "/home/ubuntu/cron_job.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /home/ubuntu/backup.sh /home/ubuntu/cron_job.sh",
      "sh /home/ubuntu/cron_job.sh"
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
    Name = "grupo4-ec2-az1a-db"
  }
}

resource "aws_ec2_tag" "grupo4_ec2_az1a_db_eni_name" {
  resource_id = aws_instance.grupo4_ec2_az1a_db.primary_network_interface_id

  key = "Name"
  value = "grupo4-eni-ec2-az1a-db"
}
