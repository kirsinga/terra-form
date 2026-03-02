
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

data "aws_subnets" "all_subnets" {}

locals {
  selected_subnet_id = length(data.aws_subnets.default_subnets.ids) > 0 ? data.aws_subnets.default_subnets.ids[0] : (length(data.aws_subnets.all_subnets.ids) > 0 ? data.aws_subnets.all_subnets.ids[0] : null)
}

module "ec2_cluster" {
  count = var.environment == "production" ? 2 : 1
  source = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 5.0"
  name = "ec2_cluster-${count.index + 1}"
  ami = "ami-05803413c51f242b7"
  instance_type = "t2.micro"
  subnet_id = local.selected_subnet_id

   tags = {
    Name = "ec2_cluster"
    environment = var.environment

  }

}