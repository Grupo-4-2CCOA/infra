output "website_beauty_barreto_url" {
  value = "http://${aws_lb.grupo4_load_balancer.dns_name}"
  description = "URL do Load Balancer do site beauty-barreto.com"
}