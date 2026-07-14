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

data "template_file" "user_data" {
  template = file("./userdata.yaml")
}

resource "aws_instance" "my_server" {
  ami                    = "ami-001089eb624938d9f"
  instance_type          = "t2.micro"
  key_name               = aws_key_pair.deployer.key_name
  vpc_security_group_ids = [aws_security_group.sg_my_server.id]

  user_data = data.template_file.user_data.rendered
  tags = {
    Name = "MyServer"
  }
}

resource "aws_s3_bucket" "bucket" {
  bucket = "my-tf-test-bucket-12349054"
  depends_on = [ aws_instance.my_server ]
}

output "public_ip" {
  value = aws_instance.my_server.public_ip
}

