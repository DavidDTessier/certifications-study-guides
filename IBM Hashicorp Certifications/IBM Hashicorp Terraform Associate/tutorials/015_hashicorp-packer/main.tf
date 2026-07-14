terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.72.0"
    }
  }
}

provider "aws" {
  profile = "default"
  region  = "us-east-2"
}

data "aws_vpc" "default_vpc" {
  id = "vpc-48f33423"
}

data "aws_ami" "packer_image" {
    //executable_users = ["self"]
    most_recent = true

    filter {
        name = "name"
        values = ["my-server-httpd"]
    }
    owners = ["self"]
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
  ami                    = data.aws_ami.packer_image.id
  instance_type          = "t2.micro" 
  vpc_security_group_ids = [aws_security_group.sg_my_server.id]

  tags = {
    Name = "MyServer-Packer"
  }
}


output "public_ip" {
  value = aws_instance.my_server[*].public_ip
}

