// Default Security Group Settings for VPC
resource "aws_default_security_group" "default-securitygroup" {
  vpc_id = aws_vpc.ECSProject-VPC.id

  ingress {
    protocol  = -1
    self      = true
    from_port = 0
    to_port   = 0
  }

  // Allows incoming connections from mySQL RDS instance
  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.ECS-Instance-SG.id]
  }

}

data "aws_secretsmanager_secret_version" "ip_address" {
  secret_id = "arn:aws:secretsmanager:us-west-2:913087840426:secret:IpAddress-8jqo2I"
}

// ECS instance Security Group, that will Apply to the EC2 instance in the Autoscaling group.
resource "aws_security_group" "ECS-Instance-SG" {
  name   = "ECS-Instance-SecurityGroup"
  vpc_id = aws_vpc.ECSProject-VPC.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [jsondecode(data.aws_secretsmanager_secret_version.ip_address.secret_string)["ipaddress"]]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [jsondecode(data.aws_secretsmanager_secret_version.ip_address.secret_string)["ipaddress"]]
  }

  // myphpadmin container port
  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = [jsondecode(data.aws_secretsmanager_secret_version.ip_address.secret_string)["ipaddress"]]
  }

  // Metabase container port
  ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = [jsondecode(data.aws_secretsmanager_secret_version.ip_address.secret_string)["ipaddress"]]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]

  }


}

//EFS Security Group, allows incoming traffic on port 2049 to the ECS Instance Security group
resource "aws_security_group" "EFS-SG" {
  name   = "EFS-SecurityGroup"
  vpc_id = aws_vpc.ECSProject-VPC.id

  ingress {
    from_port       = 2049
    to_port         = 2049
    protocol        = "tcp"
    security_groups = [aws_security_group.ECS-Instance-SG.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]

  }

}