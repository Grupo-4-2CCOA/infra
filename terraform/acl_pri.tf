resource "aws_network_acl" "grupo4_acl_pri" {
  vpc_id = aws_vpc.grupo4_vpc.id

  subnet_ids = [
    aws_subnet.grupo4_subnet_az1a_pri.id
  ]

  ingress {
    rule_no = "100"
    protocol = "tcp"
    from_port = 443
    to_port = 443
    cidr_block = "10.1.0.0/27"
    action = "allow"
  }
  ingress {
    rule_no = "110"
    protocol = "tcp"
    from_port = 80
    to_port = 80
    cidr_block = "10.1.0.0/27"
    action = "allow"
  }
  ingress {
    rule_no = "120"
    protocol = "tcp"
    from_port = 3333
    to_port = 3333
    cidr_block = "10.1.0.0/27"
    action = "allow"
  }
  ingress {
    rule_no = "200"
    protocol = "tcp"
    from_port = 22
    to_port = 22
    cidr_block = "10.1.0.0/27"
    action = "allow"
  }
  ingress {
    rule_no = "998"
    protocol = "tcp"
    from_port = 1024
    to_port = 65535
    cidr_block = "0.0.0.0/0"
    action = "allow"
  }
  ingress {
    rule_no = "999"
    protocol = "-1"
    from_port = 0
    to_port = 0
    cidr_block = "0.0.0.0/0"
    action = "deny"
  }

  egress {
    rule_no = "998"
    protocol = "-1"
    from_port = 0
    to_port = 0
    cidr_block = "10.1.0.0/27"
    action = "allow"
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
    Name = "grupo4-acl-pri"
  }
}
