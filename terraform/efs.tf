resource "aws_efs_file_system" "efs" {
  creation_token = "grupo4-efs"
  encrypted      = true
}

resource "aws_efs_mount_target" "az1a" {
  file_system_id  = aws_efs_file_system.efs.id
  subnet_id       = aws_subnet.grupo4_subnet_az1a_pri.id 
  security_groups = [aws_security_group.grupo4_sg_efs.id]
}

resource "aws_efs_mount_target" "az1b" {
  file_system_id  = aws_efs_file_system.efs.id
  subnet_id       = aws_subnet.grupo4_subnet_az1b_pub.id   
  security_groups = [aws_security_group.grupo4_sg_efs.id]
}

resource "aws_efs_mount_target" "az1c" {
  file_system_id  = aws_efs_file_system.efs.id
  subnet_id       = aws_subnet.grupo4_subnet_az1c_pub.id   
  security_groups = [aws_security_group.grupo4_sg_efs.id]
}