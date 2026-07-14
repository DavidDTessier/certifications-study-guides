# AWS Infrastructure Stack Deployment Configuration
# This file defines how to deploy the AWS infrastructure stack

deployment "development" {
  inputs = {
    aws_region            = "us-east-1"
    vpc_cidr             = "10.0.0.0/16"
    public_subnet_cidrs    = ["10.0.1.0/24", "10.0.2.0/24"]
    private_subnet_cidrs   = ["10.0.10.0/24", "10.0.20.0/24"]
    availability_zones     = ["us-east-1a", "us-east-1b"]
    instance_type         = "t3.micro"
    ami_id               = "ami-0c55b159cbfafe1f0"
    key_pair_name        = "aws-stack-demo-key"
    instance_count       = 2
    allowed_ssh_cidr     = "0.0.0.0/0"
    allowed_http_cidr    = "0.0.0.0/0"
    environment          = "dev"
    project_name        = "aws-stack-demo"
  }
}

deployment "production" {
  inputs = {
    aws_region            = "us-east-1"
    vpc_cidr             = "10.1.0.0/16"
    public_subnet_cidrs    = ["10.1.1.0/24", "10.1.2.0/24", "10.1.3.0/24"]
    private_subnet_cidrs   = ["10.1.10.0/24", "10.1.20.0/24", "10.1.30.0/24"]
    availability_zones     = ["us-east-1a", "us-east-1b", "us-east-1c"]
    instance_type         = "t3.small"
    ami_id               = "ami-0c55b159cbfafe1f0"
    key_pair_name        = "aws-stack-demo-key"
    instance_count       = 3
    allowed_ssh_cidr     = "174.112.209.210/32"  # Update with your IP address
    allowed_http_cidr    = "0.0.0.0/0"
    environment          = "prod"
    project_name        = "aws-stack-prod"
  }
}
