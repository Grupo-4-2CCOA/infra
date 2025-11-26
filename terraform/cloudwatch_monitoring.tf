resource "aws_sns_topic" "grupo4_cloudwatch_alerts" {
  name = "grupo4-cloudwatch-alerts"
  
  tags = {
    Name = "Alertas CloudWatch - Beauty Barreto"
  }
}

resource "aws_cloudwatch_log_group" "grupo4_ec2_logs" {
  name              = "/aws/ec2/grupo4"
  retention_in_days = 14
  
  tags = {
    Name = "Logs CloudWatch - Beauty Barreto"
  }
}

resource "aws_cloudwatch_dashboard" "grupo4_ec2_dashboard" {
  dashboard_name = "grupo4-ec2-monitoring"

  dashboard_body = jsonencode({
    widgets = [
      {
        type   = "metric"
        x      = 0
        y      = 0
        width  = 12
        height = 6

        properties = {
          metrics = [
            ["AWS/EC2", "CPUUtilization", "InstanceId", aws_instance.grupo4_ec2_az1a_db_0.id],
            ["AWS/EC2", "CPUUtilization", "InstanceId", aws_instance.grupo4_ec2_az1a_pri_0.id],
            ["AWS/EC2", "CPUUtilization", "InstanceId", aws_instance.grupo4_ec2_az1a_pub_0.id],
            ["AWS/EC2", "CPUUtilization", "InstanceId", aws_instance.grupo4_ec2_az1b_pub_0.id]
          ]
          view    = "timeSeries"
          stacked = false
          region  = "us-east-1"
          title   = "Uso da CPU das instâncias EC2 - Beauty Barreto"
          period  = 300
        }
      },
      {
        type   = "metric"
        x      = 0
        y      = 6
        width  = 12
        height = 6

        properties = {
          metrics = [
            ["CWAgent", "mem_used_percent", "InstanceId", aws_instance.grupo4_ec2_az1a_db_0.id],
            ["CWAgent", "mem_used_percent", "InstanceId", aws_instance.grupo4_ec2_az1a_pri_0.id],
            ["CWAgent", "mem_used_percent", "InstanceId", aws_instance.grupo4_ec2_az1a_pub_0.id],
            ["CWAgent", "mem_used_percent", "InstanceId", aws_instance.grupo4_ec2_az1b_pub_0.id]
          ]
          view    = "timeSeries"
          stacked = false
          region  = "us-east-1"
          title   = "Memory Utilization - Grupo4 EC2 Instances"
          period  = 300
        }
      },
      {
        type   = "metric"
        x      = 0
        y      = 12
        width  = 12
        height = 6

        properties = {
          metrics = [
            ["CWAgent", "disk_used_percent", "InstanceId", aws_instance.grupo4_ec2_az1a_db_0.id, "device", "/dev/sda1", "fstype", "ext4"],
            ["CWAgent", "disk_used_percent", "InstanceId", aws_instance.grupo4_ec2_az1a_pri_0.id, "device", "/dev/sda1", "fstype", "ext4"],
            ["CWAgent", "disk_used_percent", "InstanceId", aws_instance.grupo4_ec2_az1a_pub_0.id, "device", "/dev/sda1", "fstype", "ext4"],
            ["CWAgent", "disk_used_percent", "InstanceId", aws_instance.grupo4_ec2_az1b_pub_0.id, "device", "/dev/sda1", "fstype", "ext4"]
          ]
          view    = "timeSeries"
          stacked = false
          region  = "us-east-1"
          title   = "Disk Utilization - Grupo4 EC2 Instances"
          period  = 300
        }
      }
    ]
  })
}