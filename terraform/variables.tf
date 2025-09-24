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