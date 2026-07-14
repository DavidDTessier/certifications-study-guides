# Basic Terraform configuration that will provision an GCP Compute Engine instance from
# a Debian Image and use GCP GCS as the backend state configuration
terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.0"
    }
  }
    backend "gcs" {
      bucket = "tfstate-devops-03292024"
      prefix = "demo/vm/terraform.tfstate"
    }
}
provider "google" {
  credentials = file("credentials.json")
  region = "us-east1"
}

resource "google_project" "this" {
  project_id = "prg-tf-demo"
  name = "Terraform State Project"
  billing_account = var.billing_account
}

resource "google_project_service" "project_iam" {
  project = google_project.this.name
  service = "iam.googleapis.com"


  timeouts {
    create = "30m"
    update = "40m"
  }

  disable_dependent_services = true
}

resource "google_project_service" "project_compute" {
  project = "adroit-anthem-417714"
  service = "compute.googleapis.com"


  timeouts {
    create = "30m"
    update = "40m"
  }

  disable_dependent_services = true
}



resource "google_compute_instance" "example" {
  name         = "my-instance"
  machine_type = "e2-micro"
  zone         = "us-east1-b"

  tags = ["foo", "bar"]

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
      labels = {
        my_label = "value"
      }
    }
  }

  network_interface {
    network = "default"

    access_config {
      // Ephemeral public IP
    }
  }

  metadata = {
    foo = "bar"
  }

  metadata_startup_script = "echo hi > /test.txt"

  depends_on = [ google_project_service.project_compute ]

}