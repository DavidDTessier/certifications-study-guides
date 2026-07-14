variable "instance_type" {
  type = string
  default = "t2.micro"
}

variable "vpc_id" {
  type = string
  description = "VPC to attach"
  default = ""
}

variable "my_cidr_range" {
  type = string
  default = "174.112.99.39/32"
}

variable "public_key" {
  type = string
  description = "SSH public key to ssh into the ec2 instance"
}

variable "server_name" {
  type = string
  description = "Name of server"
}
