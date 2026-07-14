policy "terraform-restrict-ec2-instance" {
    source = "./restrict-ec2-instance-type.sentinel"
    enforcement_level = "hard-mandatory"
}


mock "tfplan/v2" {
  module {
    source = "mock-tfplan-v2.sentinel"
  }
}
