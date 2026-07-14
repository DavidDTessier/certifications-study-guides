
variable "ami_id" {
  type = string
  default = "ami-001089eb624938d9f"
}

locals {
  app_name = "httpd"
}

source "amazon-ebs" "httpd" {
  ami_name = "my-server-${local.app_name}"
  instance_type = "t2.micro"
  region = "us-east-2"
  source_ami = "${var.ami_id}"
  ssh_username = "ec2-user"
  tags = {
    Env = "DEMO"
    Name = "Packer-My-server-${local.app_name}"
  }
}

build {
  sources = ["source.amazon-ebs.httpd"]
  provisioner "shell" {
    inline = [
      "sudo yum install -y httpd",
      "sudo systemctl start httpd",
      "sudo systemctl enable httpd"
    ]
  }
}