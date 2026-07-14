terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.72.0"
    }
    vault = {
      source = "hashicorp/vault"
      version = "3.2.1"
    }
  }
}

provider "vault" {
  //address: (REQUIRED) URL of the Vault Server. This can be retrieved from the `VAULT_ADDR` environment variable.
  //add_addr_to_env: (Optional) if `true` the environment variable `VAULT_ADDR` in the _Terraform_ process environment will be set to the value of the `address` argument from the configuation. This is `false` by default.
  //token: (Optional) Used by Terraform to authenticate to Vault. Can be retrieve by the `VAULT_TOKEN` environment variable. If not set Terraform will attempt to read it from `~/.vault-token`

}

provider "aws" {
  region  = "us-east-2"
  access_key = data.vault_generic_secret.aws_creds.data["aws_access_key_id"]
  secret_key = data.vault_generic_secret.aws_creds.data["aws_secret_access_key"]
}

data "vault_generic_secret" "aws_creds" {
  path = "secret/aws"
}

data "aws_vpc" "default_vpc" {
  id = "vpc-48f33423"
}



resource "aws_security_group" "sg_my_server" {
  name        = "sg_my_server"
  description = "My Server Security Group"
  vpc_id      = data.aws_vpc.default_vpc.id

  ingress = [{
    description      = "HTTP"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = []
    prefix_list_ids  = []
    security_groups  = []
    self             = false
    },
    {
      description      = "SSH"
      from_port        = 22
      to_port          = 22
      protocol         = "tcp"
      cidr_blocks      = ["174.112.99.39/32"]
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = []
      self             = false
  }]

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
    prefix_list_ids  = []
    security_groups  = []
    self             = false
  }
}

resource "aws_instance" "my_server" {
  ami                    = "ami-001089eb624938d9f"
  instance_type          = "t2.nano" 
  vpc_security_group_ids = [aws_security_group.sg_my_server.id]

  tags = {
    Name = "MyServer-Packer"
  }
}


output "public_ip" {
  value = aws_instance.my_server[*].public_ip
}

