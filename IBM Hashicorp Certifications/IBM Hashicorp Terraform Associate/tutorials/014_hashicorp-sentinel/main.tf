terraform {
 cloud {
    organization = "ddtessier-org"

    workspaces {
      name = "vcs-workflow"
    }
  }
}

provider "aws" {
  profile = "default"
  region  = "us-east-2"
}

module "apache-example" {
  source  = "DavidDTessier/apache-example/aws"
  version = "1.0.3"
  server_name = var.server_name
  public_key = var.public_key
  vpc_id  = var.vpc_id
  instance_type = var.instance_type
}
