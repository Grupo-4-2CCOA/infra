variable alert_email {
    description = "Email para receber alertas do CloudWatch"
    type = string
    default = "grupo4-2ccoa@sptech.school"
}

variable ec2_ami {
    description = "AMI da EC2"
    type = string
    default = "ami-0ecb62995f68bb549"
}

variable aws_user_id {
    description = "Usuário AWS"
    type = string
    default = "155174118589"
}

variable elastic_ip_az1a_id {
    description = "ID do IP Elastico da Instancia az1a"
    type = string
    default = "eipalloc-054123fd7b4395d15"
}

variable elastic_ip_az1b_id {
    description = "ID do IP Elastico da Instancia az1b"
    type = string
    default = "eipalloc-07648e1d1e2f4b12c"
}

variable elastic_ip_az1c_id {
    description = "ID do IP Elastico da Instancia az1c"
    type = string
    default = "eipalloc-0a20b6897fb8cd116"
}