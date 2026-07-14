variable "workload_identity_pool_id" {
    type = string
    description = "The ID of the workforce IAM"
}

variable "organization_id" {
  type        = string
  description = "The organization id"
}

variable "billing_id" {
  type        = string
  description = "Billing ID"
}

variable "folder_org_policy_constraints" {
  type    = list(string)
  default = ["constraints/compute.skipDefaultNetworkCreation", "compute.disableSerialPortAccess"]
}

