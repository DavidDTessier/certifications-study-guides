provider "tfe" {
  # Configure authentication using API token from environment variable
  # Set TFE_TOKEN environment variable with your HCP Terraform API token
  token = var.tfe_token
  
  # Optional: specify hostname if using a self-hosted Terraform Enterprise instance
  # hostname = "app.terraform.io"  # Default for HCP Terraform
}