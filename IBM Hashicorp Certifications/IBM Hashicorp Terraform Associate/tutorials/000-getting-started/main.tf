# Basic Terraform configuration that will provision an EC2 instance from
# an Ubuntu AMI image

## Version Contraints
## * = (specific version ex  3.5.4)
## * != (Excludes specific version)
## * >, >= (Greater-than or Greater-than-or-equal-to --> Comparison against a specified version, allowing versions for which the comparison is true.)
## * <, <= (Less-than or Less-than-equal-to --> Comparison against a specified version, allowing versions for which the comparison is true.)
## * ~>  (pesssimistic contraint) allows only the rightmost version componenent to increment
## ** Example to allow new patch releases within a specific minor release, use the full version number:
## *** ~> 1.0.4 : Allows Terraform to install 1.0.5 and 1.0.10 but not 1.1.0
## *** ~> 1.1 : Allows Terraform to install 1.2 and 1.10 but not 2.0
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0, < 5.43" 
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "example" {
  ami           = "ami-011899242bb902164" # Ubuntu 20.04 LTS // us-east-1
  instance_type = "t2.micro"
}
