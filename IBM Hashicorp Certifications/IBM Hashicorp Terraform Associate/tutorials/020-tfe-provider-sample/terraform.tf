terraform {
  # It is 2026; ensure you are on a modern, stable version
  required_version = ">= 1.11, < 2.0"

  required_providers {
    tfe = {
      source  = "hashicorp/tfe"
      # Using ~> 0.74.0 ensures you get the latest features like 
      # native Stacks support and Project-level execution modes.
      version = "~> 0.74.0"
    }
  }
}