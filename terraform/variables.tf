variable alert_email {
    description = "Email para receber alertas do CloudWatch"
    type        = string
    default     = "grupo4-2ccoa@sptech.school"
}

variable ec2_ami {
    description = "AMI da EC2"
    type = string
    default = "ami-0360c520857e3138f"
}

variable aws_user_id {
    description = "Usuário AWS"
    type = string
    default = "376339220136"
}

variable elastic_ip_az1a_id {
    description = "ID do IP Elastico da Instancia az1a"
    type = string
    default = "eipalloc-07e4c772c75184575"
}

variable elastic_ip_az1b_id {
    description = "ID do IP Elastico da Instancia az1b"
    type = string
    default = "eipalloc-02272522139e48d68"
}

variable elastic_ip_az1c_id {
    description = "ID do IP Elastico da Instancia az1c"
    type = string
    default = "eipalloc-0e2f3e2ec099d1384"
}