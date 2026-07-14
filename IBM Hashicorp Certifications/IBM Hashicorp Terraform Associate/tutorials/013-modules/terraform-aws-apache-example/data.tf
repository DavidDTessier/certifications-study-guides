data "template_file" "user_data" {
  template = file("${abspath(path.module)}/userdata.yaml")
}

data "aws_vpc" "default_vpc" {
  filter {
    name = "tag:Name"
    values = ["Default"]
  }
}

data "aws_ami" "east-amazon-linux-2" {
  most_recent = true
  owners = ["amazon"]
  filter {
    name = "owner-alias"
    values = ["amazon"]
  }
  filter {
    name = "name"
    values = ["amzn2-ami-hvm*"]
  }
}