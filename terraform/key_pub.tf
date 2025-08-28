resource "aws_key_pair" "grupo4_key_pub" {
  key_name = "grupo4-key-pub"
  public_key = tls_private_key.grupo4_key_pub.public_key_openssh
}
