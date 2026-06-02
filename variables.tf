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
