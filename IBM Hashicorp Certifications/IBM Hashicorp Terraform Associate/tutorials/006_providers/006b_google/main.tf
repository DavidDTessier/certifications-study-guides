terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "4.7.0"
    }
  }
}

provider "google" {
  # Configuration options
  credentials = "${file("account-creds.json")}"
  project = "anthos-demo-323415"
  region = "us-central1"
  zone = "us-central1-c"
}

resource "google_compute_instance" "default" {
  name         = "test"
  machine_type = "e2-micro"
  
  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-10"
    }
  }

  network_interface {
    network = "default"

    access_config {
      // Ephemeral public IP
    }
  }

}