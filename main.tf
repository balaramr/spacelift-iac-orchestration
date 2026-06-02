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

# Dynamically fetch the latest stable Ubuntu 22.04 AMI for eu-west-1
data "aws_ssm_parameter" "ubuntu_ami" {
  name = "/aws/service/canonical/ubuntu/server/22.04/stable/current/amd64/hvm/ebs-gp2/ami-id"
}

resource "aws_instance" "app_server" {
  ami           = data.aws_ssm_parameter.ubuntu_ami.value # Uses the dynamic ID found above
  instance_type = "t2.micro"

  tags = {
    Name = "Spacelift-Managed-Server"
  }
}

data "aws_caller_identity" "current" {}

output "aws_account_id" {
  value = data.aws_caller_identity.current.account_id
}

resource "aws_s3_bucket" "orbit_storage" {
  bucket_prefix = "orbit-storage-"

  tags = {
    name      = "Orbit Labs Storage"
    managedBy = "SpaceLift"
    mission   = "First Launch"
    project   = "Orbit-labs"
  }
}


