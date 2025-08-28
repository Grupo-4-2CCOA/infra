resource "aws_key_pair" "grupo4_key_pri" {
  key_name = "grupo4-key-pri"
  public_key = tls_private_key.grupo4_key_pri.public_key_openssh
}
