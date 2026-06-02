terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }
  required_version = ">= 0.14"
}

provider "aws" {
  region = "ap-south-1"
}

resource "aws_vpc" "my_vpc" {
  cidr_block = "172.31.0.0/16"

  tags = {
    Name = var.vpc_name
  }
}


resource "aws_instance" "app_server" {
  ami           = "ami-0685bcc683dadb6b9"
  instance_type = "t3.micro"

  tags = {
    Name = var.instance_name
  }
}
