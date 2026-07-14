resource "tfe_organization" "demo_org" {
  name  = var.organization_name
  email = var.organization_email
}

resource "tfe_agent_pool" "my_agents" {
  name         = var.agent_pool_name
  organization = tfe_organization.demo_org.name
}

resource "tfe_organization_default_settings" "org_default" {
  organization           = tfe_organization.demo_org.name
  default_execution_mode = "agent"
  default_agent_pool_id  = tfe_agent_pool.my_agents.id
}

resource "tfe_workspace" "my_workspace" {
  name       = var.workspace_name
  organization = tfe_organization.demo_org.name
  # This workspace will use the org defaults, and will report those defaults as
  # the values of its corresponding attributes. Use depends_on to get accurate
  # values immediately, and to ensure reliable behavior of tfe_workspace_run.
  depends_on = [tfe_organization_default_settings.org_default]
}