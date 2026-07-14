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

locals {
    apis = [
            "iam.googleapis.com",
            "cloudresourcemanager.googleapis.com",
            "iamcredentials.googleapis.com", 
            "sts.googleapis.com"
           ]
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
  name       = "Demo Workload IAM Project"
  project_id = "prj-demo-wrkld-iam-${random_integer.project_id.result}"
  billing_account = var.billing_id
  folder_id = google_folder.developers.id
}

resource "google_project_service" "enable_project_apis" {
  project = google_project.my_project-in-a-folder.id
  for_each   = toset(local.apis)
  service = each.value

  timeouts {
    create = "30m"
    update = "40m"
  }

  disable_on_destroy = false
}

resource "google_iam_workload_identity_pool" "workload_identity_pool" {
  workload_identity_pool_id = var.workload_identity_pool_id
  project = google_project.my_project-in-a-folder.project_id
  display_name              = "Dev Pool for CICD"
  description               = "Identity pool for automated test"
  disabled                  = false
}

resource "google_iam_workload_identity_pool_provider" "terraform_cloud_provider" {
  workload_identity_pool_id          = google_iam_workload_identity_pool.workload_identity_pool.workload_identity_pool_id
  workload_identity_pool_provider_id = "tfcloud-prvdr"
  project = google_project.my_project-in-a-folder.project_id
  display_name                       = "Terraform Cloud"
  description                        = "SAML 2.0 identity pool provider for automated test"
  disabled                           = false
  attribute_mapping                  = {
    "google.subject"        = "assertion.terraform_workspace_d"
    "attribute.tf_org" = "assertion.terraform_organization_id"
  }
  attribute_condition = "assertion.terraform_organization_id=='DavidTessierTestingOrg' && assertion.terraform_workspace_id=='ws-uwYQGp5YegoG5JiW'"
  oidc {
    issuer_uri = "https://app.terraform.io"
  }
}
