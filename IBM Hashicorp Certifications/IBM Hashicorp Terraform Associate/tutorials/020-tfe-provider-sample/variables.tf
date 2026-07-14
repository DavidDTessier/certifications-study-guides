# TFE Authentication
variable "tfe_token" {
  type        = string
  description = "HCP Terraform API token for authentication"
  sensitive   = true
}

# Organization Configuration
variable "organization_name" {
  type        = string
  description = "Name of the HCP Terraform organization to create"
  default     = "demo-org"
}

variable "organization_email" {
  type        = string
  description = "Email address for the organization"
  default     = "admin@example.com"
}

# Agent Pool Configuration
variable "agent_pool_name" {
  type        = string
  description = "Name of the agent pool to create"
  default     = "default-agents"
}

# Workspace Configuration
variable "workspace_name" {
  type        = string
  description = "Name of the workspace to create"
  default     = "demo-workspace"
}
