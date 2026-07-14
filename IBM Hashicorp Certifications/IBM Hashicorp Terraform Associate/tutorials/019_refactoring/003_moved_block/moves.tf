# Specifies the moved block to move the resource from its old address to its new address

moved {
  from = module.apache-instance.aws_instance.my_server
  to  = module.apache-instance-2.aws_instance.my_server
}

moved {
  from = module.apache-instance.aws_security_group.sg_my_server
  to  = module.apache-instance-2.aws_security_group.sg_my_server
}

moved {
  from = module.apache-instance.aws_key_pair.deployer
  to  = module.apache-instance-2.aws_key_pair.deployer
}