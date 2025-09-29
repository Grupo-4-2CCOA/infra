resource "aws_default_network_acl" "grupo4_default_rtb" {
  default_network_acl_id = aws_vpc.grupo4_vpc.default_network_acl_id

  ingress {
    rule_no = "999"
    protocol = "-1"
    from_port = 0
    to_port = 0
    cidr_block = "0.0.0.0/0"
    action = "deny"
  }

  egress {
    rule_no = "999"
    protocol = "-1"
    from_port = 0
    to_port = 0
    cidr_block = "0.0.0.0/0"
    action = "deny"
  }

  tags = {
    Name = "grupo4-acl-default"
  }
}
