terraform {

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "5.39.1"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.6.2"
    }
  }
}

provider "random" {
  # Configuration options
}

provider "google" {
  # Configuration options
}
