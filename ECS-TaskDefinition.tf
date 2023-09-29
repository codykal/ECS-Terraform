resource "aws_ecs_task_definition" "ECS-TaskDefinition-myPHPAdmin" {
  family                   = "ECS-TaskDefinition-myPHPAdmin"
  execution_role_arn       = "arn:aws:iam::913087840426:role/ecsTaskExecutionRole"
  cpu                      = 224
  requires_compatibilities = ["EC2"]
  runtime_platform {
    operating_system_family = "LINUX"
    cpu_architecture        = "X86_64"
  }

  container_definitions = jsonencode([
    {
      name  = "phpmyadmin"
      image = "docker.io/phpmyadmin:latest"
      environment = [
        {
          name  = "PMA_HOST"
          value = aws_db_instance.MySQL-Instance.endpoint
        }
      ]
      cpu       = 224
      memory    = 182
      essential = true
      portMappings = [
        {
          containerPort = 80
          hostPort      = 8080
          protocol      = "tcp"
        }
      ]

    }
  ])

}

resource "aws_ecs_task_definition" "ECS-TaskDefinition-metabase" {
    family = "ECS-TaskDefinition-metabase"
  
}