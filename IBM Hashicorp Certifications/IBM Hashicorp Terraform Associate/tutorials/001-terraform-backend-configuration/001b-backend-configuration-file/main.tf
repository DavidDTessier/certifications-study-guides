# Basic Terraform configuration that will provision an EC2 instance from
# an Ubuntu AMI image and use AWS S3 as the backend with a partion configuration the backend in passed in on the command line 
# using the config.s3.tfbackend file

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  backend "s3" {} # Passed in via command line 
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "example" {
  ami           = "ami-011899242bb902164" # Ubuntu 20.04 LTS // us-east-1
  instance_type = "t2.micro"
}
