resource "aws_network_acl" "grupo4_acl_pub" {
  vpc_id = aws_vpc.grupo4_vpc.id
  
  subnet_ids = [
    aws_subnet.grupo4_subnet_az1a_pub.id,
    aws_subnet.grupo4_subnet_az1b_pub.id
  ]

  ingress {
    rule_no = "100"
    protocol = "tcp"
    from_port = 443
    to_port = 443
    cidr_block = "0.0.0.0/0"
    action = "allow"
  }

  ingress {
    rule_no = "110"
    protocol = "tcp"
    from_port = 80
    to_port = 80
    cidr_block = "0.0.0.0/0"
    action = "allow"
  }
  
  ingress {
    rule_no = "120"
    protocol = "tcp"
    from_port = 3333
    to_port = 3333
    cidr_block = "0.0.0.0/0"
    action = "allow"
  }
  ingress {
    rule_no = "130"
    protocol = "tcp"
    from_port = 5173
    to_port = 5173
    cidr_block = "0.0.0.0/0"
    action = "allow"
  }
  ingress {
    rule_no = "200"
    protocol = "tcp"
    from_port = 22
    to_port = 22
    cidr_block = "0.0.0.0/0"
    action = "allow"
  }
  ingress {
    rule_no = "300"
    protocol = "tcp"
    from_port = 2049
    to_port = 2049
    cidr_block = "10.1.0.0/27"
    action = "allow"
  }
  ingress {
    rule_no = "990"
    protocol = "-1"
    from_port = 0
    to_port = 0
    cidr_block = "10.1.0.32/28"
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
    rule_no = "999"
    protocol = "-1"
    from_port = 0
    to_port = 0
    cidr_block = "0.0.0.0/0"
    action = "allow"
  }

  tags = {
    Name = "grupo4-acl-pub"
  }
}