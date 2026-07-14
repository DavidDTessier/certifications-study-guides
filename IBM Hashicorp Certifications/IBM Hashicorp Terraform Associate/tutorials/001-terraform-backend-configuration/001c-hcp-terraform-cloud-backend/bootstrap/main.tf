terraform {
  required_providers {
    tfe = {
        source = "hashicorp/tfe"
        version = "0.53.0"
    }
  }
 
 cloud {
      organization = "DavidTessierTestingOrg"

      workspaces {
        name = "tfe-management-workspace"
      }
   }
   
}

locals {
    prefix = "tfe"
    organization_name = "DavidTessierTestingOrg"
}


resource "tfe_organization" "this" {
    name = local.organization_name
    email = "david.d.tessier@gmail.com"
}

resource "tfe_project" "management" {
  name = "${local.prefix}-bootstrap"
  organization = tfe_organization.this.name
  lifecycle {
    create_before_destroy = false
  }
}

resource "tfe_workspace" "management" {
    name = "${local.prefix}-management-workspace"
    organization = tfe_organization.this.name
    project_id = tfe_project.management.id
    tag_names = ["management", "source:cli"]
}

resource "tfe_project" "app-project" {
  name = "${local.prefix}-app-prj"
  organization = tfe_organization.this.name
}

resource "tfe_workspace" "app-workspace" {
    name = "${local.prefix}-app-workspace"
    project_id = tfe_project.app-project.id
    organization = tfe_organization.this.name
    tag_names = ["app", "source:cli"]
}