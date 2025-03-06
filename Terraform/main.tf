# AWS Provider configuration
provider "aws" {
  region = var.aws_region
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# VPC
module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  name   = "deepseek-vpc"
  cidr   = var.vpc_cidr
  azs             = [var.availability_zone]
  public_subnets  = [var.public_subnet_cidr]
  enable_dns_hostnames = true
  enable_dns_support   = true
  map_public_ip_on_launch = true
}

# Security Group
module "security_group" {
  source      = "terraform-aws-modules/security-group/aws"
  name        = "deepseek-sg"
  description = "Security group for DeepSeek EC2 instance"
  vpc_id      = module.vpc.vpc_id
 
  ingress_with_cidr_blocks = [
    { from_port = 22, to_port = 22, protocol = "tcp", cidr_blocks = "0.0.0.0/0" },
    { from_port = 3000, to_port = 3000, protocol = "tcp", cidr_blocks = "0.0.0.0/0" },
    { from_port = 11434, to_port = 11434, protocol = "tcp", cidr_blocks = "0.0.0.0/0" }
  ]
  egress_with_cidr_blocks = [{ from_port = 0, to_port = 0, protocol = "-1", cidr_blocks = "0.0.0.0/0" }]
}
 
# IAM Role and Instance Profile
module "iam" {
  source     = "terraform-aws-modules/iam/aws//modules/iam-assumable-role"
  create_role = true
  role_name  = "newrole-deepseek2"
  trusted_role_services = ["ec2.amazonaws.com"]
}
 
resource "aws_iam_role_policy_attachment" "s3_readonly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
  role       = module.iam.iam_role_name
}
 
resource "aws_iam_instance_profile" "deepseek_profile" {
  name = "deepseek-profile2"
  role = module.iam.iam_role_name
}
