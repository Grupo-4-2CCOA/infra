resource "aws_sns_topic_subscription" "grupo4_email_notifications" {
  topic_arn = aws_sns_topic.grupo4_cloudwatch_alerts.arn
  protocol  = "email"
  endpoint  = var.alert_email
}

resource "aws_cloudwatch_metric_alarm" "grupo4_ec2_db_cpu_high" {
  alarm_name          = "Alto Uso de CPU - Instância do Banco de Dados"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "300"
  statistic           = "Average"
  threshold           = "80"
  alarm_description   = "Utilização de CPU alta na instância do banco de dados"
  alarm_actions       = [aws_sns_topic.grupo4_cloudwatch_alerts.arn]

  dimensions = {
    InstanceId = aws_instance.grupo4_ec2_az1a_db_0.id
  }

  tags = {
    Name = "grupo4-ec2-db-cpu-high"
  }
}

resource "aws_cloudwatch_metric_alarm" "grupo4_ec2_pri_cpu_high" {
  alarm_name          = "Alto Uso de CPU - Instância do Back-end"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "300"
  statistic           = "Average"
  threshold           = "80"
  alarm_description   = "Utilização de CPU alta na instância do back-end"
  alarm_actions       = [aws_sns_topic.grupo4_cloudwatch_alerts.arn]

  dimensions = {
    InstanceId = aws_instance.grupo4_ec2_az1a_pri_0.id
  }

  tags = {
    Name = "grupo4-ec2-pri-cpu-high"
  }
}

resource "aws_cloudwatch_metric_alarm" "grupo4_ec2_pub_az1a_cpu_high" {
  alarm_name          = "Alto Uso de CPU - Instância Pública AZ1A"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "300"
  statistic           = "Average"
  threshold           = "80"
  alarm_description   = "Utilização de CPU da instância pública AZ1A"
  alarm_actions       = [aws_sns_topic.grupo4_cloudwatch_alerts.arn]

  dimensions = {
    InstanceId = aws_instance.grupo4_ec2_az1a_pub_0.id
  }

  tags = {
    Name = "grupo4-ec2-pub-az1a-cpu-high"
  }
}

resource "aws_cloudwatch_metric_alarm" "grupo4_ec2_pub_az1b_cpu_high" {
  alarm_name          = "Alto Uso de CPU - Instância Pública AZ1B"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = "300"
  statistic           = "Average"
  threshold           = "80"
  alarm_description   = "Utilização de CPU da instância pública AZ1B"
  alarm_actions       = [aws_sns_topic.grupo4_cloudwatch_alerts.arn]

  dimensions = {
    InstanceId = aws_instance.grupo4_ec2_az1b_pub_0.id
  }

  tags = {
    Name = "grupo4-ec2-pub-az1b-cpu-high"
  }
}

resource "aws_cloudwatch_metric_alarm" "grupo4_ec2_db_memory_high" {
  alarm_name          = "Alto Uso de Memória - Instância do Banco de Dados"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "2"
  metric_name         = "mem_used_percent"
  namespace           = "CWAgent"
  period              = "300"
  statistic           = "Average"
  threshold           = "85"
  alarm_description   = "Utilização de memória da instância do banco de dados"
  alarm_actions       = [aws_sns_topic.grupo4_cloudwatch_alerts.arn]

  dimensions = {
    InstanceId = aws_instance.grupo4_ec2_az1a_db_0.id
  }

  tags = {
    Name = "grupo4-ec2-db-memory-high"
  }
}

resource "aws_cloudwatch_metric_alarm" "grupo4_ec2_pri_memory_high" {
  alarm_name          = "Alto Uso de Memória - Instância do Back-end"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "2"
  metric_name         = "mem_used_percent"
  namespace           = "CWAgent"
  period              = "300"
  statistic           = "Average"
  threshold           = "85"
  alarm_description   = "Utilização de memória da instância do back-end"
  alarm_actions       = [aws_sns_topic.grupo4_cloudwatch_alerts.arn]

  dimensions = {
    InstanceId = aws_instance.grupo4_ec2_az1a_pri_0.id
  }

  tags = {
    Name = "grupo4-ec2-pri-memory-high"
  }
}

resource "aws_cloudwatch_metric_alarm" "grupo4_ec2_pub_az1a_memory_high" {
  alarm_name          = "Alto Uso de Memória - Instância Pública AZ1A"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "2"
  metric_name         = "mem_used_percent"
  namespace           = "CWAgent"
  period              = "300"
  statistic           = "Average"
  threshold           = "85"
  alarm_description   = "Utilização de memória da instância pública AZ1A"
  alarm_actions       = [aws_sns_topic.grupo4_cloudwatch_alerts.arn]

  dimensions = {
    InstanceId = aws_instance.grupo4_ec2_az1a_pub_0.id
  }

  tags = {
    Name = "grupo4-ec2-pub-az1a-memory-high"
  }
}

resource "aws_cloudwatch_metric_alarm" "grupo4_ec2_pub_az1b_memory_high" {
  alarm_name          = "Alto Uso de Memória - Instância Pública AZ1B"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "2"
  metric_name         = "mem_used_percent"
  namespace           = "CWAgent"
  period              = "300"
  statistic           = "Average"
  threshold           = "85"
  alarm_description   = "Utilização de memória da instância pública AZ1B"
  alarm_actions       = [aws_sns_topic.grupo4_cloudwatch_alerts.arn]

  dimensions = {
    InstanceId = aws_instance.grupo4_ec2_az1b_pub_0.id
  }

  tags = {
    Name = "grupo4-ec2-pub-az1b-memory-high"
  }
}

resource "aws_cloudwatch_metric_alarm" "grupo4_ec2_db_disk_high" {
  alarm_name          = "Alto Uso de Disco - Instância do Banco de Dados"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "2"
  metric_name         = "disk_used_percent"
  namespace           = "CWAgent"
  period              = "300"
  statistic           = "Average"
  threshold           = "80"
  alarm_description   = "Utilização de disco alta na instância do banco de dados"
  alarm_actions       = [aws_sns_topic.grupo4_cloudwatch_alerts.arn]

  dimensions = {
    InstanceId = aws_instance.grupo4_ec2_az1a_db_0.id
    device     = "/dev/sda1"
    fstype     = "ext4"
  }

  tags = {
    Name = "grupo4-ec2-db-disk-high"
  }
}

resource "aws_cloudwatch_metric_alarm" "grupo4_ec2_pri_disk_high" {
  alarm_name          = "Alto Uso de Disco - Instância do Back-end"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "2"
  metric_name         = "disk_used_percent"
  namespace           = "CWAgent"
  period              = "300"
  statistic           = "Average"
  threshold           = "80"
  alarm_description   = "Utilização de disco alta na instância do back-end"
  alarm_actions       = [aws_sns_topic.grupo4_cloudwatch_alerts.arn]

  dimensions = {
    InstanceId = aws_instance.grupo4_ec2_az1a_pri_0.id
    device     = "/dev/sda1"
    fstype     = "ext4"
  }

  tags = {
    Name = "grupo4-ec2-pri-disk-high"
  }
}

resource "aws_cloudwatch_metric_alarm" "grupo4_ec2_pub_az1a_disk_high" {
  alarm_name          = "Alto Uso de Disco - Instância Pública AZ1A"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "2"
  metric_name         = "disk_used_percent"
  namespace           = "CWAgent"
  period              = "300"
  statistic           = "Average"
  threshold           = "80"
  alarm_description   = "Utilização de disco alta na instância pública AZ1A"
  alarm_actions       = [aws_sns_topic.grupo4_cloudwatch_alerts.arn]

  dimensions = {
    InstanceId = aws_instance.grupo4_ec2_az1a_pub_0.id
    device     = "/dev/sda1"
    fstype     = "ext4"
  }

  tags = {
    Name = "grupo4-ec2-pub-az1a-disk-high"
  }
}

resource "aws_cloudwatch_metric_alarm" "grupo4_ec2_pub_az1b_disk_high" {
  alarm_name          = "Alto Uso de Disco - Instância Pública AZ1B"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = "2"
  metric_name         = "disk_used_percent"
  namespace           = "CWAgent"
  period              = "300"
  statistic           = "Average"
  threshold           = "80"
  alarm_description   = "Utilização de disco alta na instância pública AZ1B"
  alarm_actions       = [aws_sns_topic.grupo4_cloudwatch_alerts.arn]

  dimensions = {
    InstanceId = aws_instance.grupo4_ec2_az1b_pub_0.id
    device     = "/dev/sda1"
    fstype     = "ext4"
  }

  tags = {
    Name = "grupo4-ec2-pub-az1b-disk-high"
  }
}
