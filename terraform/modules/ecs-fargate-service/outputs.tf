output "alb_dns_name" {
  description = "Point your DNS record (Route 53 alias) here."
  value       = aws_lb.this.dns_name
}

output "alb_zone_id" {
  value = aws_lb.this.zone_id
}

output "cluster_name" {
  value = aws_ecs_cluster.this.name
}

output "service_name" {
  value = aws_ecs_service.this.name
}

output "app_security_group_id" {
  description = "Allow this group in your database security group."
  value       = aws_security_group.app.id
}
