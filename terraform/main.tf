locals {
  project = {
    id      = var.project_id
    name    = data.google_project.project.name
    number  = data.google_project.project.number
  }
  _services = [
    "compute"
  ]
  service_accounts_default = {
    compute      = data.google_compute_default_service_account.default.email
  }
  service_account_cloud_services = (
    "${local.project.number}@cloudservices.gserviceaccount.com"
  )
  service_accounts_services_api = {
    for s in local._services : s => "${s}.googleapis.com"
  }
}

data "google_project" "project" {
  project_id = var.project_id
}

data "google_compute_default_service_account" "default" {}

resource "google_project_service_identity" "service_identity" {
  for_each   = local.service_accounts_services_api
  provider   = google-beta
  project    = local.project.id
  service    = each.value
}

resource "time_sleep" "wait_for_service_agent_readiness" {
  depends_on = [
    google_project_service_identity.service_identity,
  ]
  # SLO for IAM provisioning of Service Agents is 7min.
  create_duration = "420s"
}
