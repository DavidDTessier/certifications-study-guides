terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "5.39.1"
    }
  }
}

variable "project_id" {
  type = string
}

variable "resource_name" {
  type = string
  default = "demo"
}

variable "location" {
  type = string
  default = "us-central1"
}

resource "google_compute_network" "demo_vpc" {
  name                    = "${var.resource_name}-vpc"
  project                 = var.project_id
  routing_mode            = "GLOBAL"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "demo-subnet" {
  name          = "${var.resource_name}-subnet"
  project                 = var.project_id
  ip_cidr_range = "10.128.0.0/20"
  region        = var.location
  network       = google_compute_network.demo_vpc.id
  log_config {
    aggregation_interval = "INTERVAL_10_MIN"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}