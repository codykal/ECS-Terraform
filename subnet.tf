resource "aws_subnet" "public1" {
  vpc_id                  = aws_vpc.ECSProject-VPC.id
  map_public_ip_on_launch = true
  availability_zone       = "us-west-2a"
  cidr_block              = "10.0.0.0/24"

  tags = {
    ECSProject = "PublicSubnet1"
  }

}

resource "aws_subnet" "public2" {
  vpc_id                  = aws_vpc.ECSProject-VPC.id
  map_public_ip_on_launch = true
  availability_zone       = "us-west-2b"
  cidr_block              = "10.0.1.0/24"

  tags = {
    ECSProject = "PublicSubnet2"
  }

}

resource "aws_subnet" "private1" {
  vpc_id            = aws_vpc.ECSProject-VPC.id
  availability_zone = "us-west-2a"
  cidr_block        = "10.0.2.0/24"

  tags = {
    ECSProject = "PrivateSubnet1"
  }


}

resource "aws_subnet" "private2" {
  vpc_id            = aws_vpc.ECSProject-VPC.id
  availability_zone = "us-west-2b"
  cidr_block        = "10.0.3.0/24"
  tags = {
    ECSProject = "PrivateSubnet2"
  }
}