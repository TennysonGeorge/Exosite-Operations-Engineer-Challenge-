output "nginx_lb_dns_name" {
  description = "The DNS name of the Nginx Load Balancer"
  value       = aws_lb.nginx_lb.dns_name
}
