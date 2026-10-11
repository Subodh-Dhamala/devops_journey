variable "aws_region" {
  description = "AWS region for the infrastructure"
  type        = string
  default     = "ap-south-1"
}

variable "my_ip" {
  description = "My public IPv4 address, without /32"
  type        = string
}

variable "ami_id" {
  description = "Verified Amazon Linux 2023 AMI ID for the selected region"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}
