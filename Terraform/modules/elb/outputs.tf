# -------------------
# LB Outputs
# -------------------

output "alb_dns_name" {
  description = "DNS name of the ALB"
  value       = aws_lb.app_alb.dns_name
}

output "alb_arn" {
  description = "ARN of the ALB"
  value       = aws_lb.app_alb.arn
}

output "alb_security_group_id" {
  description = "Security Group ID for the ALB"
  value       = aws_security_group.alb_sg.id
}

# ---------------------
# Target Group Outputs
# ---------------------

output "target_group_arn" {
  description = "ARN of the Target Group"
  value       = aws_lb_target_group.app_tg.arn
}

# -------------------
# Listener Outputs
# -------------------

output "listener_arn" {
  description = "ARN of the Listener"
  value       = aws_lb_listener.app_alb_listener.arn
}