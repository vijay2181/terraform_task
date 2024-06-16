output "autoscaling_group_name" {
  value = aws_autoscaling_group.example.name
}

output "load_balancer_dns" {
  value = aws_lb.example.dns_name
}

output "target_group_arn" {
  value = aws_lb_target_group.example.arn
}
