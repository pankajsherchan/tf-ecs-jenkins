output "ecr_repository_name" {
  value = aws_ecr_repository.app.name
}

output "ecs_cluster_name" {
  value = aws_ecs_cluster.main.name
}

output "ecs_service_name" {
  value = aws_ecs_service.app.name
}

output "task_execution_role_arn" {
  value = aws_iam_role.ecs_task_execution.arn
}

output "cloudwatch_log_group_name" {
  value = aws_cloudwatch_log_group.ecs.name
}

output "alb_dns_name" {
  value = aws_lb.main.dns_name
}
