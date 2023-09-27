resource "aws_launch_template" "ECS-Cluster" {
  name          = "ECS-Launch-Configuration"
  image_id      = "ami-038937b3d6616035f"
  instance_type = "t2.micro"

  user_data            = <<-EOF
         #!/bin/bash
         echo ECS_CLUSTER=${aws_ecs_cluster.ECSProject-Cluster.name} >> /etc/ecs/ecs.config
         EOF
  
  tags = {
    ECSProject = "ASG-LaunchConfig"
  }
}