//create a VPC with CIDR block
resource "aws_vpc" "vpc_levelup" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"
  enable_dns_support = "true"
  enable_dns_hostnames = "true"

  tags = {
    Name = "vpc_levelup"
  }

  
}
//public subnet 
resource "aws_subnet" "levelup_subnet1" {
  vpc_id     = aws_vpc.vpc_levelup.id
  cidr_block = "10.0.1.0/24"
  map_public_ip_on_launch = "true"
  availability_zone = "us-east-2a"

  tags = {
    Name = "levelup_subnet1"
  }
}
resource "aws_subnet" "levelup_subnet2" {
  vpc_id     = aws_vpc.vpc_levelup.id
  cidr_block = "10.0.2.0/24"
  map_public_ip_on_launch = "true"
  availability_zone = "us-east-2b"

  tags = {
    Name = "levelup_subnet2"
  }
}
resource "aws_subnet" "levelup_subnet3" {
  vpc_id     = aws_vpc.vpc_levelup.id
  cidr_block = "10.0.3.0/24"
  map_public_ip_on_launch = "true"
  availability_zone = "us-east-2c"

  tags = {
    Name = "levelup_subnet3"
  }
}
//private subnet
resource "aws_subnet" "levelup_private_subnet1" {
  vpc_id     = aws_vpc.vpc_levelup.id
  cidr_block = "10.0.4.0/24"
  map_public_ip_on_launch = "false"
  availability_zone = "us-east-2a"

  tags = {
    Name = "levelup_private_subnet1"
  }
}
resource "aws_subnet" "levelup_private_subnet2" {
  vpc_id     = aws_vpc.vpc_levelup.id
  cidr_block = "10.0.5.0/24"
  map_public_ip_on_launch = "false"
  availability_zone = "us-east-2b"

  tags = {
    Name = "levelup_private_subnet2"
  }
}
resource "aws_subnet" "levelup_private_subnet3" {
  vpc_id     = aws_vpc.vpc_levelup.id
  cidr_block = "10.0.6.0/24"
  map_public_ip_on_launch = "false"
  availability_zone = "us-east-2c"

  tags = {
    Name = "levelup_private_subnet3"
  }
}

//internet gateway
resource "aws_internet_gateway" "levelup_igw" {
  vpc_id = aws_vpc.vpc_levelup.id

  tags = {
    Name = "levelup_igw"
  }
}
//routing table 
resource "aws_route_table" "levelup_public_rt" {
  vpc_id = aws_vpc.vpc_levelup.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.levelup_igw.id
  }
  tags= {
    Name = "levelup_public_rt"
  }
}
//associate public subnet with routing table
resource "aws_route_table_association" "levelup_public_rt_assoc1" {
  subnet_id      = aws_subnet.levelup_subnet1.id
  route_table_id = aws_route_table.levelup_public_rt.id
}
resource "aws_route_table_association" "levelup_public_rt_assoc2" {
  subnet_id      = aws_subnet.levelup_subnet2.id
  route_table_id = aws_route_table.levelup_public_rt.id
}
resource "aws_route_table_association" "levelup_public_rt_assoc3" {
  subnet_id      = aws_subnet.levelup_subnet3.id
  route_table_id = aws_route_table.levelup_public_rt.id
}