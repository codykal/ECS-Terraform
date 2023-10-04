resource "aws_ecs_task_definition" "ECS-TaskDefinition-myPHPAdmin" {
  family                   = "ECS-TaskDefinition-myPHPAdmin"
  execution_role_arn       = "arn:aws:iam::913087840426:role/ecsTaskExecutionRole"
  cpu                      = 224
  network_mode             = "bridge"
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
  family                   = "ECS-TaskDefinition-metabase"
  execution_role_arn       = "arn:aws:iam::913087840426:role/ecsTaskExecutionRole"
  cpu                      = 700
  memory                   = 700
  network_mode             = "bridge"
  requires_compatibilities = ["EC2"]
  runtime_platform {
    operating_system_family = "LINUX"
    cpu_architecture        = "X86_64"
  }

  container_definitions = jsonencode([
    {
      name  = "metabase"
      image = "docker.io/metabase/metabase:latest"
      mountPoints = [{
        sourceVolume  = "metabase-volume"
        containerPath = "/mnt"
      }]
      environment = [
        {
          name  = "MB_DB_FILE"
          value = "/mnt/metabase.db"
        }
      ]
      cpu       = 700
      memory    = 700
      essential = true
      portMappings = [
        {
          containerPort = 3000
          hostPort      = 3000
          protocol      = "tcp"
        }
      ]
    }
  ])

  volume {
    name = "metabase-volume"

    efs_volume_configuration {
      file_system_id     = aws_efs_file_system.EFS-Filesystem.id
      root_directory     = "/"
      transit_encryption = "DISABLED"


    }
  }

}