
resource "random_integer" "project_id" {
  min = 1
  max = 1000
}

resource "google_folder" "shared" {
  display_name = "Shared"
  parent       = "organizations/${var.organization_id}"
}

resource "google_folder" "non_prod" {
  display_name = "NonProd"
  parent       = "organizations/${var.organization_id}"
}

resource "google_project" "fe_project" {
  name            = "FrontEnd"
  project_id      = "prj-fe-${random_integer.project_id.result}"
  billing_account = var.billing_account
  folder_id       = google_folder.non_prod.folder_id
}

resource "google_project" "be_project" {
  name            = "Backend"
  billing_account = var.billing_account
  project_id      = "prj-be-${random_integer.project_id.result}"
  folder_id       = google_folder.non_prod.folder_id

}

resource "google_project" "shared_project" {
  name            = "VPC Host Project"
  billing_account = var.billing_account
  project_id      = "prj-vpc-host-${random_integer.project_id.result}"
  folder_id       = google_folder.shared.folder_id
}

resource "google_compute_network" "shared_vpc" {
  name                    = "vpc-app-shared"
  project                 = google_project.shared_project.project_id
  routing_mode            = "REGIONAL"
  auto_create_subnetworks = false
}

resource "google_project_service" "shared_project" {
  project = google_project.shared_project.project_id
  service = "compute.googleapis.com"

  timeouts {
    create = "30m"
    update = "40m"
  }

  disable_on_destroy = true
}

resource "google_project_service" "fe_project" {
  project = google_project.fe_project.project_id
  service = "compute.googleapis.com"

  timeouts {
    create = "30m"
    update = "40m"
  }

  disable_on_destroy = true
}

resource "google_project_service" "be_project" {
  project = google_project.be_project.project_id
  service = "compute.googleapis.com"

  timeouts {
    create = "30m"
    update = "40m"
  }

  disable_on_destroy = true
}

resource "google_compute_subnetwork" "subnet-fe" {
  name          = "fe-subnet"
  project       = google_project.shared_project.project_id
  ip_cidr_range = "192.168.0.0/27"
  region        = "us-east1"
  network       = google_compute_network.shared_vpc.name
}

resource "google_compute_subnetwork" "subnet-be" {
  name          = "be-subnet"
  project       = google_project.shared_project.project_id
  ip_cidr_range = "192.168.1.0/27"
  region        = "us-central1"
  network       = google_compute_network.shared_vpc.name
}

resource "google_compute_firewall" "allow_ssh_ping_shared_vpc" {
  name    = "allow-ssh-ping-shared-vpc"
  project = google_project.shared_project.project_id
  network = google_compute_network.shared_vpc.name

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["22", "3389"]
  }
  source_ranges = ["0.0.0.0/0"]
}

/*

# A host project provides network resources to associated service projects.
resource "google_compute_shared_vpc_host_project" "host" {
  project = google_project.shared_project.project_id
}

# A service project gains access to network resources provided by its
# associated host project.
resource "google_compute_shared_vpc_service_project" "fe_service_proj" {
  host_project    = google_compute_shared_vpc_host_project.host.project
  service_project = google_project.fe_project.project_id
}

resource "google_compute_shared_vpc_service_project" "be_service_proj" {
  host_project    = google_compute_shared_vpc_host_project.host.project
  service_project = google_project.be_project.project_id
}
*/