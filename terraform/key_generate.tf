# key para EC2s públicas:
resource "tls_private_key" "grupo4_key_pub" {
  algorithm = "RSA"
  rsa_bits = 2048
}
resource "local_file" "grupo4_key_pub_local" {
  content = tls_private_key.grupo4_key_pub.private_key_pem
  filename = "grupo4-key-pub-local.pem"
  file_permission = "0400"
}
# key para EC2s privadas:
resource "tls_private_key" "grupo4_key_pri" {
  algorithm = "RSA"
  rsa_bits = 2048
}
resource "local_file" "grupo4_key_pri_local" {
  content = tls_private_key.grupo4_key_pri.private_key_pem
  filename = "grupo4-key-pri-local.pem"
  file_permission = "0400"
}
# key para a EC2 de banco de dados:
resource "tls_private_key" "grupo4_key_db" {
  algorithm = "RSA"
  rsa_bits = 2048
}
resource "local_file" "grupo4_key_db_local" {
  content = tls_private_key.grupo4_key_db.private_key_pem
  filename = "grupo4-key-db-local.pem"
  file_permission = "0400"
}
