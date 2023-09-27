resource "aws_ecs_cluster" "ECSProject-Cluster" {
  name = "ECSProject-Cluster"

}

# //ECS instance definition
# resource "aws_instance" "ECS-Instance" {
#   ami                  = "ami-038937b3d6616035f"
#   instance_type        = "t2.micro"
#   iam_instance_profile = aws_iam_instance_profile.ecs_instance_profile.name
#   user_data            = <<-EOF
#         #!/bin/bash
#         echo ECS_CLUSTER=${aws_ecs_cluster.ECSProject-Cluster.name} >> /etc/ecs/ecs.config
#         EOF
#   subnet_id = aws_subnet.private1.id
#   associate_public_ip_address = true
#     tags = {
#         ECSProject = "ECS-Instance"
#     }

# }


//IAM role that allows access to ECS from the EC2 instance.
resource "aws_iam_role" "ecs_execution_role" {
  name = "ecs_execution_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action = "sts:AssumeRole",
      Principal = {
        Service = "ecs.amazonaws.com"
      },
      Effect = "Allow",
    }]
  })

  tags = {
    ECSProject = "ECS IAM Role"
  }

}

//IAM profile that uses the IAM Role defined above.
resource "aws_iam_instance_profile" "ecs_instance_profile" {
  name = "ecs_instance_profile"
  role = aws_iam_role.ecs_execution_role.name

  tags = {
    ECSProject = "ECS Instance Profile"
  }
}