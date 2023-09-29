resource "aws_ecs_service" "ECS-Service-myPHPAdmin" {
  name            = "ECS-Service-myPHPAdmin"
  cluster         = aws_ecs_cluster.ECSProject-Cluster.id
  task_definition = aws_ecs_task_definition.ECS-TaskDefinition-myPHPAdmin.arn
  desired_count   = 1

  network_configuration {
    subnets         = [aws_subnet.public1.id]
    security_groups = [aws_security_group.ECS-Instance-SG.id]
  }

  force_new_deployment = true

  capacity_provider_strategy {
    capacity_provider = aws_ecs_capacity_provider.ECSProject-ECS-provider.name
    weight            = 100
  }

  depends_on = [aws_autoscaling_group.ECS-asg]

}

resource "aws_ecs_service" "ECS-Service-metabase" {
  name            = "ECS-Service-metabase"
  cluster         = aws_ecs_cluster.ECSProject-Cluster.id
  task_definition = aws_ecs_task_definition.ECS-TaskDefinition-metabase.arn
  desired_count   = 1

  network_configuration {
    subnets         = [aws_subnet.public1.id]
    security_groups = [aws_security_group.ECS-Instance-SG.id]
  }

  force_new_deployment = true

  capacity_provider_strategy {
    capacity_provider = aws_ecs_capacity_provider.ECSProject-ECS-provider.name
    weight            = 100
  }

  depends_on = [aws_autoscaling_group.ECS-asg]
}