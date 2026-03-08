terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    http = {
      source = "hashicorp/http"
    }
  }
}

provider "aws" {
  region = var.AWS_REGION
}

data "aws_region" "current" {
}

data "aws_availability_zones" "available" {
}

provider "http" {
}