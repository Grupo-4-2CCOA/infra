resource "aws_eip" "grupo4_eip_az1a" {
    domain = "vpc"
    tags = {
        Name = "grupo4-eip-az1a"
    }
}