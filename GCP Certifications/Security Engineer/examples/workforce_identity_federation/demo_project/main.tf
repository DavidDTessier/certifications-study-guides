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

resource "random_integer" "project_id" {
  min = 1
  max = 1000
}

# Top-level folder under an organization.
resource "google_folder" "developers" {
  display_name = "Developers"
  parent       = var.organization_id
}

resource "google_folder_organization_policy" "folder_policies_enforcement" {
  for_each   = toset(var.folder_org_policy_constraints)
  folder     = google_folder.developers.id
  constraint = each.value

  boolean_policy {
    enforced = true
  }
}

resource "google_project" "my_project-in-a-folder" {
  name       = "Demo Workforce IAM Project"
  project_id = "prj-demo-wrk-iam-${random_integer.project_id.result}"
  billing_account = var.billing_id
  folder_id = google_folder.developers.id
}

resource "google_project_iam_policy" "project" {
  project     = google_project.my_project-in-a-folder.id
  policy_data = data.google_iam_policy.admin.policy_data
}

data "google_iam_policy" "admin" {
  binding {
    role = "roles/storage.admin"

    members = [
      "principal://iam.googleapis.com/locations/global/workforcePools/${var.workforce_pool_id}/subject/dev1@daviddtessierhotmail.onmicrosoft.com",
    ]
  }
}


