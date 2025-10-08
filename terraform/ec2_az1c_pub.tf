resource "aws_instance" "grupo4_ec2_az1c_pub_rabbitmq" {
    ami = var.ec2_ami
    instance_type = "t3.micro"
    key_name = "vockey"    
    subnet_id = aws_subnet.grupo4_subnet_az1a_pub.id
    vpc_security_group_ids = [aws_security_group.grupo4_sg_rabbitmq.id]
    associate_public_ip_address = true
    
    user_data = file("files/shell/ec2_rabbitmq.sh")

    connection {
        type = "ssh"
        user = "ubuntu"
        private_key = file("./labsuser.pem")
        host = self.public_ip
    }

    provisioner "file" {
      source = "files/scripts/compose.yaml"
      destination = "/home/ubuntu/compose.yaml"
    }

    tags = {
        Name = "grupo4-ec2-az1c-pub-rabbitmq"
    }
}