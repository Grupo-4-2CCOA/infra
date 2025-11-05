# resource "aws_route53_zone" "grupo4_zone" {
#   name = "beauty-barreto.com"
# }

# resource "aws_route53_record" "grupo4_alias_lb" {
#   zone_id = aws_route53_zone.grupo4_zone.zone_id
#   name = "web.beauty-barreto.com"
#   type = "A"

#   alias {
#     name = aws_lb.grupo4_load_balancer.dns_name
#     zone_id = aws_lb.grupo4_load_balancer.zone_id
#     evaluate_target_health = true
#   }
# }