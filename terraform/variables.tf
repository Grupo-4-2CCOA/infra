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
    default = "229245958983"
}

variable elastic_ip_az1a_id {
    description = "ID do IP Elastico da Instancia az1a Web"
    type = string
    default = "eipalloc-0faa3662e7a486915"
}

variable elastic_ip_az1b_id {
    description = "ID do IP Elastico da Instancia az1b Web"
    type = string
    default = "eipalloc-03a6255bb45ee4a44"
}

variable elastic_ip_az1c_id {
    description = "ID do IP Elastico da Instancia az1c Grafana"
    type = string
    default = "eipalloc-0f84bff456286b404"
}

variable "public_ip" {
    description = "IP Público da Instância Pública AZ1A"
    type = string
    default = "100.30.131.174"
}

variable "private_rest_api_ip" {
    description = "IP Privado da Instância SpringBoot & RabbitMQ"
    type = string
    default = "10.1.0.37"
}

variable "private_database_api_ip" {
    description = "IP Privado da Instância do Banco de Dados"
    type = string
    default = "10.1.0.41"
}

variable "instance_user" {
    description = "Usuário padrão das instâncias EC2"
    type = string
    default = "ubuntu"
}