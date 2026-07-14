# __generated__ by Terraform
# Please review these resources and move them into your main configuration files.

# __generated__ by Terraform
resource "aws_key_pair" "deployer" {
  key_name   = "deployer-key"
  public_key = null
  region     = "us-east-1"
  tags       = {}
  tags_all   = {}
}

# __generated__ by Terraform from "sg-00cb44156dffb09ec"
resource "aws_security_group" "sg_my_server" {
  description = "My Server Security Group"
  egress = [{
    cidr_blocks      = ["0.0.0.0/0"]
    description      = ""
    from_port        = 0
    ipv6_cidr_blocks = ["::/0"]
    prefix_list_ids  = []
    protocol         = "-1"
    security_groups  = []
    self             = false
    to_port          = 0
  }]
  ingress = [{
    cidr_blocks      = ["0.0.0.0/0"]
    description      = "HTTP"
    from_port        = 80
    ipv6_cidr_blocks = []
    prefix_list_ids  = []
    protocol         = "tcp"
    security_groups  = []
    self             = false
    to_port          = 80
    }, {
    cidr_blocks      = ["174.112.99.39/32"]
    description      = "SSH"
    from_port        = 22
    ipv6_cidr_blocks = []
    prefix_list_ids  = []
    protocol         = "tcp"
    security_groups  = []
    self             = false
    to_port          = 22
  }]
  name                   = "sg_my_server"
  region                 = "us-east-1"
  revoke_rules_on_delete = null
  tags                   = {}
  tags_all               = {}
  vpc_id                 = "vpc-816043fb"
}

# __generated__ by Terraform
resource "aws_instance" "my_server" {
  ami                                  = "ami-0199fa5fada510433"
  associate_public_ip_address          = true
  availability_zone                    = "us-east-1d"
  disable_api_stop                     = false
  disable_api_termination              = false
  ebs_optimized                        = false
  force_destroy                        = false
  get_password_data                    = false
  hibernation                          = false
  instance_initiated_shutdown_behavior = "stop"
  instance_type                        = "t2.micro"
  ipv6_address_count                   = 0
  ipv6_addresses                       = []
  key_name                             = "deployer-key"
  monitoring                           = false
  placement_partition_number           = 0
  private_ip                           = "172.31.23.214"
  region                               = "us-east-1"
  secondary_private_ips                = []
  security_groups                      = ["sg_my_server"]
  source_dest_check                    = true
  subnet_id                            = "subnet-606acd2d"
  tags = {
    Name = "myserver"
  }
  tags_all = {
    Name = "myserver"
  }
  tenancy                     = "default"
  user_data                   = "#cloud-config\npackages:\n  - httpd\nruncmd:\n  - systemctl start httpd\n  - sudo systemctl enable httpd"
  user_data_replace_on_change = null
  volume_tags                 = null
  vpc_security_group_ids      = ["sg-00cb44156dffb09ec"]
  capacity_reservation_specification {
    capacity_reservation_preference = "open"
  }
  cpu_options {
    core_count       = 1
    threads_per_core = 1
  }
  credit_specification {
    cpu_credits = "standard"
  }
  enclave_options {
    enabled = false
  }
  maintenance_options {
    auto_recovery = "default"
  }
  metadata_options {
    http_endpoint               = "enabled"
    http_protocol_ipv6          = "disabled"
    http_put_response_hop_limit = 1
    http_tokens                 = "optional"
    instance_metadata_tags      = "disabled"
  }
  primary_network_interface {
    network_interface_id = "eni-0b9347761ae81ed9a"
  }
  private_dns_name_options {
    enable_resource_name_dns_a_record    = false
    enable_resource_name_dns_aaaa_record = false
    hostname_type                        = "ip-name"
  }
  root_block_device {
    delete_on_termination = true
    encrypted             = false
    iops                  = 100
    tags                  = {}
    tags_all              = {}
    throughput            = 0
    volume_size           = 8
    volume_type           = "gp2"
  }
}
