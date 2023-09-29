resource "aws_vpc" "ECSProject-VPC" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    ECSProject = "VPC"
  }
}


resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.ECSProject-VPC.id
  tags = {
    ECSProject = "internet_gateway"
  }
}

resource "aws_route_table" "route_table" {
  vpc_id = aws_vpc.ECSProject-VPC.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.internet_gateway.id
  }
}

resource "aws_route_table_association" "subnet_route" {
  subnet_id      = aws_subnet.public1.id
  route_table_id = aws_route_table.route_table.id
}

resource "aws_route_table_association" "subnet2_route" {
  subnet_id      = aws_subnet.public2.id
  route_table_id = aws_route_table.route_table.id
}