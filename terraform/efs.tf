resource "aws_efs_file_system" "efs" {
  creation_token = "BeautyBarreto-efs"
  encrypted      = true
}

# Mount target na subnet privada AZ1a
resource "aws_efs_mount_target" "az1a" {
  file_system_id  = aws_efs_file_system.efs.id
  subnet_id       = aws_subnet.grupo4_subnet_az1a_pri.id 
  security_groups = [aws_security_group.grupo4_sg_efs.id]
}

# Mount target na subnet privada AZ1b
resource "aws_efs_mount_target" "az1b" {
  file_system_id  = aws_efs_file_system.efs.id
  subnet_id       = aws_subnet.grupo4_subnet_az1b_pub.id   
  security_groups = [aws_security_group.grupo4_sg_efs.id]
}