# Specifies resources to import into the Terraform state

import {
  # The full address: module.<module_name>.<resource_type>.<resource_name>
  to = module.apache-instance.aws_instance.my_server
  # The cloud provider's physical ID for the existing resource
  id = "i-0dee2b360e22d3135"
}

import {
  # The full address: module.<module_name>.<resource_type>.<resource_name>
  to = module.apache-instance.aws_security_group.sg_my_server
  # The cloud provider's physical ID for the existing resource
  id = "sg-00cb44156dffb09ec"
}

import {
  # The full address: module.<module_name>.<resource_type>.<resource_name>
  to = module.apache-instance.aws_key_pair.deployer
  # The cloud provider's physical ID for the existing resource
  id = "deployer-key"
}