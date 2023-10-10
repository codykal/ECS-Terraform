resource "aws_cloudwatch_log_group" "ecs_logs" {
  name              = "/ecs/my-ecs-service-logs"
  retention_in_days = 14
}