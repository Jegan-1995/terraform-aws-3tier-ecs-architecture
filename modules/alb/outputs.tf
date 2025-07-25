output "arn" {
  description = "ALB ARN"
  value       = aws_lb.main.arn
}

output "dns_name" {
  description = "ALB DNS name"
  value       = aws_lb.main.dns_name
}

output "target_group_arn" {
  description = "Target group ARN"
  value       = aws_lb_target_group.app.arn
}

output "security_group_id" {
  description = "ALB security group ID"
  value       = aws_security_group.alb.id
}
