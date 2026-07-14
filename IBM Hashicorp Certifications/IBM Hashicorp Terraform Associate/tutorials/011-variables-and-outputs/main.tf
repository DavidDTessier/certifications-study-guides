terraform {

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.region
}


module "aws_server" {
    source = ".//aws_server"
    instance_type = "t2.micro"
}

