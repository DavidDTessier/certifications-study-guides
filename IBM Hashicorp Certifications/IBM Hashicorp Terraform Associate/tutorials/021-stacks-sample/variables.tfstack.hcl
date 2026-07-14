# AWS Stack Variables
# Define variables for the AWS infrastructure stack

variable "aws_region" {
  type        = string
  description = "AWS region for deployment"
  default     = "us-east-1"
}

variable "vpc_cidr" {
  type        = string
  description = "CIDR block for VPC"
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidrs" {
  type        = list(string)
  description = "CIDR blocks for public subnets"
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnet_cidrs" {
  type        = list(string)
  description = "CIDR blocks for private subnets"
  default     = ["10.0.10.0/24", "10.0.20.0/24"]
}

variable "availability_zones" {
  type        = list(string)
  description = "Availability zones for subnets"
  default     = ["us-east-1a", "us-east-1b"]
}

variable "instance_type" {
  type        = string
  description = "EC2 instance type"
  default     = "t3.micro"
}

variable "ami_id" {
  type        = string
  description = "AMI ID for EC2 instances"
  default     = "ami-0c55b159cbfafe1f0"
}

variable "key_pair_name" {
  type        = string
  description = "EC2 Key Pair name for SSH access"
  default     = ""
}

variable "instance_count" {
  type        = number
  description = "Number of EC2 instances to create"
  default     = 2
}

variable "allowed_ssh_cidr" {
  type        = string
  description = "CIDR block allowed for SSH access"
  default     = "0.0.0.0/0"
}

variable "allowed_http_cidr" {
  type        = string
  description = "CIDR block allowed for HTTP/HTTPS access"
  default     = "0.0.0.0/0"
}

variable "environment" {
  type        = string
  description = "Environment tag for resources"
  default     = "dev"
}

variable "project_name" {
  type        = string
  description = "Project name for resource tagging"
  default     = "aws-stack-demo"
}
