terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

provider "aws" {
  region = "eu-west-1"
}

# Clean /16 VPC Network Boundary Base
resource "aws_vpc" "main" {
  cidr_block = "172.31.0.0/16"
  tags = {
    Name    = "Orbit Labs VPC"
    Project = "Orbit-labs"
  }
}

# Subnet safely carved inside the parent VPC space
resource "aws_subnet" "main" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "172.31.16.0/20"
  availability_zone = "eu-west-1a"
  tags = {
    Name    = "Orbit Labs Subnet"
    Project = "Orbit-labs"
  }
}
