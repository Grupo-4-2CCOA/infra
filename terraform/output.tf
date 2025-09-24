output "output_private_ip_backend" {
  value = aws_instance.grupo4_ec2_az1a_pri_0.private_ip
  description = "IP Privado do Servidor de Java"
}

output "output_private_ip_database" {
  value = aws_instance.grupo4_ec2_az1a_db.private_ip
  description = "IP Privado do Servidor de Banco de Dados"  
}