Terraform to provision an EC2 instance that is running Apache.

Not intended for production use.

Just showcasing how to create a terraform module on terraform registry.

```hcl

provider "aws" {
  profile = "default"
  region  = "us-east-2"
}

module "apache" {
    source = ".//terraform-aws-apache-example"
    server_name = "myserver"
    public_key = "ssh-rsa xxxxx"
    vpc_id = "my-vpc_id" --> defaults to Default VPC if not specified
    my_cidr_range = "0.0.0.0/32"
    instance_type = "t2.micro"
}

```