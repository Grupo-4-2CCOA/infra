output "website_beauty_barreto_url_az1a" {
  value = "http://${aws_instance.grupo4_ec2_az1a_pub_0.public_ip}:80"
  description = "IP Público do Servidor Web az1a"
}

output "website_beauty_barreto_url_az1b" {
  value = "http://${aws_instance.grupo4_ec2_az1b_pub_0.public_ip}:80"
  description = "IP Público do Servidor Web az1b"
}