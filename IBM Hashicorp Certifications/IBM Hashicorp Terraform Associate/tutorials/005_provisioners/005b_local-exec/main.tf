terraform {
  # v1.1+
  #cloud {
  # organization = "dtessier-org"

  #workspaces {
  # name = "provisioners"
  #}
  #}

  /*
  < v1.1
backend "remote" {
    hostname = "app.terraform.io"
    organization = "company"

    workspaces {
      prefix = "my-app-"
    }
  }
*/

  required_providers {
    aws = {
      source = "hashicorp/aws"
      /* version = "3.72.0" --> tf associate 002*/
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  profile = "dave-aws-sandbox"
  region  = "us-east-1"
}

data "aws_vpc" "default_vpc" {
  id = var.vpc_id
}

data "aws_ami" "amzLinux" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server*"]
  }
  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}

resource "aws_key_pair" "deployer" {
  key_name   = "deployer-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDE7fV9UD7FfHALdHw8hGtPADZBYLqdIw/SUvVhN51Ygc3JEL+2c7ZGhnQN2boHaH1yDUfaqSkbP2PUYamV6axhM2s0sowQY9XLJjcSmnpTnsVplHfQZKQSO9etclWJ0Gr50wjIBQtlMC6asOtYZt3ozCkBkatcvRccSXXGV1MzibeF0Hek7PJ/VEXqu/fSAMH8I9smkMxAdZhip0GtsAotEJ3nNNj3++77Ej4gfP9a2mvXSlfcDZOJQ45L1YbS0ySszARTVkOtoB3uCaUiUP/vsG31Yrn9qAk7FeolzjypioSAOIGaKJAZz41X2FiNAx7r955Xfh61b+xhzT+t9GcsXuhXFHr2pTfxLHOG9Fclq08qm9Spb5aqp846j31GGsC7YsyvGusK6iQLeekwQQSXr7PmymF3b+gh9Zy28gPHeyB/O/W3k9bYRmOPFcmc55nhptNolHOatbR0Eb9s9ZB771sacPC29BL/bt51ivqcPXD+g/fLwsnsjre0OdZIbn8= dtessier@MacBook-Pro.phub.net.cable.rogers.com"
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

/*
DEPRECATED in terraform 0.12 and later 
data "template_file" "user_data" {
  template = file("./userdata.yaml")
}
*/



resource "aws_instance" "my_server" {
  ami                    = data.aws_ami.amzLinux.id
  instance_type          = var.instance_type
  key_name               = aws_key_pair.deployer.key_name
  vpc_security_group_ids = [aws_security_group.sg_my_server.id]

  user_data = templatefile("./userdata.yaml", {}) # data.template_file.user_data.rendered
  provisioner "local-exec" {
    working_dir = "/tmp"
    command     = "echo ${self.private_ip} >> private_ips.txt"
  }

  tags = {
    Name = "MyServer"
  }
}

output "public_ip" {
  value = aws_instance.my_server.public_ip
}
