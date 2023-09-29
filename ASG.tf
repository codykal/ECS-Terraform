
// Launch Template for ECS Cluster, sets image to Amazon Linux 2, and in the user data block, sets up the connection to the ECS cluster.
resource "aws_launch_template" "ECS-Cluster-LT" {
  name          = "ECS-Launch-Configuration"
  image_id      = "ami-038937b3d6616035f"
  instance_type = "t2.micro"

  key_name               = "Project3-SSHKey"
  vpc_security_group_ids = [aws_security_group.ECS-Instance-SG.id]

  // Based on predefined IAM role created by AWS.
  iam_instance_profile {
    name = "ecsInstanceRole"
  }

  user_data = <<-EOF
         #!/bin/bash
         echo ECS_CLUSTER=${aws_ecs_cluster.ECSProject-Cluster.name} >> /etc/ecs/ecs.config
         EOF

  tags = {
    ECSProject = "ASG-LT"
  }
}

// EC2 Autoscaling Group
resource "aws_autoscaling_group" "ECS-asg" {
  vpc_zone_identifier = [aws_subnet.public1.id]
  desired_capacity    = 1
  max_size            = 1
  min_size            = 1

  launch_template {
    id      = aws_launch_template.ECS-Cluster-LT.id
    version = "$Latest"
  }

  tag {
    key                 = "AmazonECSManaged"
    value               = true
    propagate_at_launch = true
  }
}