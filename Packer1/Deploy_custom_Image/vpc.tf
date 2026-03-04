//AWS VPC resource module 
resource "aws_vpc" "aws_vpc_levelup" {

  cidr_block                       = var.cidr
  instance_tenancy                 = var.instance_tenancy
  enable_dns_hostnames             = var.enable_dns_hostnames
  enable_dns_support               = var.enable_dns_support

  tags = {
      name = var.vpcname
      environment = var.vpcenvironment
  }
  
}

//aws internet gateway resource
resource "aws_internet_gateway" "levelup_igw" {
  vpc_id = aws_vpc.aws_vpc_levelup.id

  tags = {
    Name = "levelup_igw"
    environment = var.vpcenvironment
  }
}
//aws subnet resource
resource "aws_subnet" "levelup_subnet1" {
  vpc_id     = aws_vpc.aws_vpc_levelup.id
  cidr_block = var.subnet1_cidr
  map_public_ip_on_launch = true
  availability_zone = var.subnet1_az

  tags = {
    Name = "levelup_subnet1"
    environment = var.vpcenvironment
  }
}

//aws route table resource
resource "aws_route_table" "levelup_public_rt" {
  vpc_id = aws_vpc.aws_vpc_levelup.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.levelup_igw.id  
  }
    tags = {
      Name = "levelup_public_rt"
      environment = var.vpcenvironment
    }
  }

  //AWS route table association resource
resource "aws_route_table_association" "levelup_public_rt_assoc1" {
  subnet_id      = aws_subnet.levelup_subnet1.id
  route_table_id = aws_route_table.levelup_public_rt.id

}
//aws security group resource
resource "aws_security_group" "levelup_sg" {
  name        = "levelup_sg"
  description = "Security group for levelup VPC"
  vpc_id      = aws_vpc.aws_vpc_levelup.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
    tags = {
        Name = "levelup_sg"
        environment = var.vpcenvironment
    }
}    
