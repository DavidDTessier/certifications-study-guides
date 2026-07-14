terraform {
  # v1.1+
  /*  cloud {
    organization = "dtessier-org"

    workspaces {
      name = "provisioners"
    }
  }
*/
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
      source  = "hashicorp/aws"
       /* version = "3.72.0" --> tf associate 002*/
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  profile = "dave-aws-sandbox"
  region  = "us-east-1"
}

data "cloudinit_config" "server_config" {
  gzip = false
  base64_encode = false
  part {
    content_type = "text/cloud-config"
    content = templatefile("${path.module}/server.yaml", {})
  }
}

data "aws_vpc" "default_vpc" {
  id = var.vpc_id
}



data "aws_ami" "amzLinux" {
  most_recent = true
  owners = ["amazon"]
  filter {
    name = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server*"]
  }
  filter {
    name = "root-device-type"
    values = ["ebs"]
  }
  filter {
    name = "virtualization-type"
    values = ["hvm"]
  }
  filter {
    name = "architecture"
    values = ["x86_64"]
  }
}

resource "aws_vpc" "web_server_vpc" {
  cidr_block = var.cidr_block

  tags = {
    Name = "web-server-vpc"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.web_server_vpc.id 

  tags = {
    Name = "vpc_igw"
  }
}

resource "aws_route_table" "terra_rt" {
  vpc_id = aws_vpc.web_server_vpc.id
  tags = {
    Name = "public_rt_tbl"
  }
}

resource "aws_route" "terra_rt" {
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.igw.id
  route_table_id = aws_route_table.terra_rt.id
}

resource "aws_route_table_association" "public_rt_asso" {
  subnet_id = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.terra_rt.id
}

resource "aws_subnet" "public_subnet" {
  vpc_id = aws_vpc.web_server_vpc.id
  map_public_ip_on_launch = true
  cidr_block = var.public_subnet_cidr
  availability_zone = "us-east-1a"

  tags = {
    Name = "public-subnet"
  }

}

resource "aws_security_group" "web_server" {
  name        = "allow_web_traffic"
  description = "Allow HTTP traffic to my server"
  vpc_id = aws_vpc.web_server_vpc.id

  ingress = [{
    description      = "SSH from VPC"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0", aws_vpc.web_server_vpc.cidr_block]
    ipv6_cidr_blocks = []
    prefix_list_ids  = []
    security_groups  = []
    self             = false

  },
  {
    description      = "HTTP"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0", aws_vpc.web_server_vpc.cidr_block]
    prefix_list_ids  = []
    ipv6_cidr_blocks = []
    security_groups  = []
    self             = false
    
  },
  {
    description      = "HTTPS"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0", aws_vpc.web_server_vpc.cidr_block]
    prefix_list_ids  = []
    ipv6_cidr_blocks = []
    security_groups  = []
    self             = false
    
  }
  ]

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    prefix_list_ids  = []
    security_groups  = []
    self             = false
  }

  tags = {
    Name = "allow_ssh_http"
  }
}

resource "aws_network_interface" "terra_net_interface" {
  subnet_id = aws_subnet.public_subnet.id
  security_groups = [ aws_security_group.web_server.id ]
}

resource "aws_eip" "terra_eip" {
  network_interface = aws_network_interface.terra_net_interface.id
  associate_with_private_ip = aws_network_interface.terra_net_interface.private_ip
  depends_on = [ aws_internet_gateway.igw, aws_instance.web_server ]
  
}

resource "aws_instance" "web_server" {
  ami                    = data.aws_ami.amzLinux.id
  instance_type          = var.instance_type
  availability_zone = "us-east-1a"
  
  network_interface {
    device_index = 0
    network_interface_id = aws_network_interface.terra_net_interface.id
  }

user_data = "${data.cloudinit_config.server_config.rendered}" 
/*
  user_data =  <<-EOF
  #!/biin/bash
  echo "** Installing apache2"
  sudo apt update -y
  sudo apt install apache2 -y
  sudo systemctl start apache2
  echo "*** Completed Intalling apache2***" | sudo tee /var/www/html/index.html
  EOF
*/

  tags = {
    Name = "terraform-web-server"
  }
}




output "public_dns" {
  value = aws_instance.web_server.public_ip
}
