resource "aws_key_pair" "grupo4_key_db" {
  key_name = "grupo4-key-database"
  public_key = tls_private_key.grupo4_key_db.public_key_openssh
}
