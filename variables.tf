variable "instance_name" {
  description = "Value of the Name tag for the EC2 instance"
  type        = string
  default     = "spacelift-app-server"
}

variable "vpc_name" {
  description = "Name of the VPC"
  type        = string
  default     = "spacelift-vpc"
}

variable "subnet_id" {
  type        = string
  description = "ID of the subnet from networking stack"
}

data "aws_subnet" "selected" {
  id = var.subnet_id
}

data "aws_vpc" "selected" {
  id = data.aws_subnet.selected.vpc_id
}

resource "aws_security_group" "app" {
  name        = "orbit-labs-app-sg"
  description = "Security group for Orbit Labs app"
  vpc_id      = data.aws_vpc.selected.id

  tags = {
    name    = "Orbit Labs App SG"
    project = "Orbit-labs"
  }
}
