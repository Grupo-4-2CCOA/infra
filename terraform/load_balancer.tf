# resource "aws_lb_target_group" "grupo4_target_group" {
#   name     = "grupo4-target-group"
#   port     = 80
#   protocol = "HTTP"
#   vpc_id   = aws_vpc.grupo4_vpc.id

#   health_check {
#     path     = "/"
#     protocol = "HTTP"
#     matcher  = "200"
#   }
# }

# resource "aws_lb" "grupo4_load_balancer" {
#   name               = "beauty-barreto-load-balancer"
#   internal           = false
#   load_balancer_type = "application"
#   security_groups    = [aws_default_security_group.grupo4_sg_default.id]
#   subnets            = [aws_subnet.grupo4_subnet_az1a_pub.id, aws_subnet.grupo4_subnet_az1b_pub.id]

#   tags = {
#     Name = "beauty-barreto-load-balancer"
#   }
# }

# resource "aws_lb_listener" "grupo4_listener" {
#   load_balancer_arn = aws_lb.grupo4_load_balancer.arn
#   port              = 80
#   protocol          = "HTTP"
#   default_action {
#     type             = "forward"
#     target_group_arn = aws_lb_target_group.grupo4_target_group.arn
#   }
# }

# resource "aws_lb_target_group_attachment" "grupo4_attach_az1a_pub" {
#   target_group_arn = aws_lb_target_group.grupo4_target_group.arn
#   target_id        = aws_instance.grupo4_ec2_az1a_pub_0.id
#   port             = 80
# }

# resource "aws_lb_target_group_attachment" "grupo4_attach_az1b_pub" {
#   target_group_arn = aws_lb_target_group.grupo4_target_group.arn
#   target_id        = aws_instance.grupo4_ec2_az1b_pub_0.id
#   port             = 80
# }