terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.34.0"
    }
  }
}

provider "aws" {
  profile = "default"
  region  = "us-east-1"
}

module "apache-instance" {
   source      = "../../modules/terraform-aws-apache-example"
   server_name = "myserver"
   public_key  = var.public_key
}


