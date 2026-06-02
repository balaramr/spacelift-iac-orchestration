terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

# 1. Configured Region to eu-west-1
provider "aws" {
  region = "eu-west-1"
}

# 2. Configured clean Ubuntu 22.04 LTS AMI for eu-west-1
resource "aws_instance" "app_server" {
  ami           = "ami-0d940f23d527c3041"
  instance_type = "t2.micro"

  tags = {
    Name = "Spacelift-Managed-Server"
  }
}

data "aws_caller_identity" "current" {}

output "aws_account_id" {
  value = data.aws_caller_identity.current.account_id
}
