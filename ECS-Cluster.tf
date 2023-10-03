
// Base Cluster definition
resource "aws_ecs_cluster" "ECSProject-Cluster" {
  name = "Project-Cluster"
}

resource "aws_ecs_capacity_provider" "ECSProject-ECS-provider" {
  name = "Capacity-Provider"

  auto_scaling_group_provider {
    auto_scaling_group_arn = aws_autoscaling_group.ECS-asg.arn
  }

}

resource "aws_ecs_cluster_capacity_providers" "ECSProject-Cluster-Capacity-Provider" {
  cluster_name = aws_ecs_cluster.ECSProject-Cluster.name

  capacity_providers = [aws_ecs_capacity_provider.ECSProject-ECS-provider.name]

  default_capacity_provider_strategy {
    base              = 1
    weight            = 100
    capacity_provider = aws_ecs_capacity_provider.ECSProject-ECS-provider.name
  }



}


