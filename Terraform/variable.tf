variable "aws_region" {
  description = "AWS region"
  type        = string
}

variable "ami" {
  description = "Ami for the instance"
  type        = string
}
 
variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
}
 
variable "availability_zone" {
  description = "AWS Availability Zone"
  type        = string
}
 
variable "public_subnet_cidr" {
  description = "Public subnet CIDR block"
  type        = string
}
 
variable "instance_type" {
  description = "EC2 instance type"
  type        = string
}

variable "key_name" {
  description = "Path to key"
  type        = string
}

variable "project" {
  description = "Project name"
  type        = string
}

variable "environment" {
  description = "Environment name (e.g., dev, staging, prod)"
  type        = string
}
