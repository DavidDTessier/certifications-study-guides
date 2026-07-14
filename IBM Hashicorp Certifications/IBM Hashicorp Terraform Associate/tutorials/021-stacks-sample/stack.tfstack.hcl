# AWS Infrastructure Stack
# This stack creates a complete AWS infrastructure setup including VPC, security groups, and EC2 instances

component "aws_infrastructure" {
  source = "./components/aws-infrastructure.tf"
  
  inputs = {
    aws_region            = var.aws_region
    vpc_cidr             = var.vpc_cidr
    public_subnet_cidrs    = var.public_subnet_cidrs
    private_subnet_cidrs   = var.private_subnet_cidrs
    availability_zones     = var.availability_zones
    instance_type         = var.instance_type
    ami_id               = var.ami_id
    key_pair_name        = var.key_pair_name
    instance_count       = var.instance_count
    allowed_ssh_cidr     = var.allowed_ssh_cidr
    allowed_http_cidr    = var.allowed_http_cidr
    environment          = var.environment
    project_name        = var.project_name
  }
  
  providers = {
    aws = provider.aws.main
  }
}
