terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "~> 5.0"
    }
    
  }
  cloud {
      organization = "DavidTessierDemoOrg"

      workspaces {
        project = "demo-workspace"
        tags = [ "demo","source:cli"  ]
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

