
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  
  region = var.AWS_REGION
}

data "aws_vpc" "default" {
  default = true
}

data "aws_subnets" "default_subnets" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

module "ec2_cluster" {
  count = var.environment == "production" ? 2 : 1
  source = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 5.0"
  name = "ec2_cluster-${count.index + 1}"
  ami = "ami-05803413c51f242b7"
  instance_type = "t2.micro"
  subnet_id = data.aws_subnets.default_subnets.ids[count.index % length(data.aws_subnets.default_subnets.ids)]

   tags = {
    Name = "ec2_cluster"
    environment = var.environment

  }

}