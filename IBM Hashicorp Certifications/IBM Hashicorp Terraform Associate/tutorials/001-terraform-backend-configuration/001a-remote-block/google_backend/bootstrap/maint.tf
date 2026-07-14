terraform {
    required_providers {
      google = {
        source = "hashicorp/google"
        version = "~> 5.0"
      }
    }
   backend "gcs" {
      bucket = "tfstate-devops-03292024"
      prefix = "demo/boostrap/terraform.tfstate"
    }
    
}

provider "google" {
  credentials = "${file("account-creds.json")}"
  region = "us-east1"
}

import {
  to = google_project.terraform_state
  id = "prg-tf-state"
}

import {
  to = google_storage_bucket.terraform_state
  id = "tfstate-devops-03292024"
}

resource "google_project" "terraform_state" {
  project_id = "prg-tf-state"
  name = "Terraform State Project"
  billing_account = var.billing_account
}

resource "google_storage_bucket" "terraform_state" {
  name = "tfstate-devops-03292024"
  project = google_project.terraform_state.project_id
  uniform_bucket_level_access = true
  versioning {
    enabled = true
  }
  location = "US"
}