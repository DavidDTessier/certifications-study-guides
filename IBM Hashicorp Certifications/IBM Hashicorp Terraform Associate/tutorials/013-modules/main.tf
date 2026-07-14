terraform {

}

provider "aws" {
  profile = "default"
  region  = "us-east-2"
}

module "apache" {
    source = ".//terraform-aws-apache-example"
    server_name = "myserver"
    public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDE7fV9UD7FfHALdHw8hGtPADZBYLqdIw/SUvVhN51Ygc3JEL+2c7ZGhnQN2boHaH1yDUfaqSkbP2PUYamV6axhM2s0sowQY9XLJjcSmnpTnsVplHfQZKQSO9etclWJ0Gr50wjIBQtlMC6asOtYZt3ozCkBkatcvRccSXXGV1MzibeF0Hek7PJ/VEXqu/fSAMH8I9smkMxAdZhip0GtsAotEJ3nNNj3++77Ej4gfP9a2mvXSlfcDZOJQ45L1YbS0ySszARTVkOtoB3uCaUiUP/vsG31Yrn9qAk7FeolzjypioSAOIGaKJAZz41X2FiNAx7r955Xfh61b+xhzT+t9GcsXuhXFHr2pTfxLHOG9Fclq08qm9Spb5aqp846j31GGsC7YsyvGusK6iQLeekwQQSXr7PmymF3b+gh9Zy28gPHeyB/O/W3k9bYRmOPFcmc55nhptNolHOatbR0Eb9s9ZB771sacPC29BL/bt51ivqcPXD+g/fLwsnsjre0OdZIbn8= dtessier@MacBook-Pro.phub.net.cable.rogers.com"
}