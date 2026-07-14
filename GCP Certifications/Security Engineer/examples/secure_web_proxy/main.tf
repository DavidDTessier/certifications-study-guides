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
     tls = {
      source = "hashicorp/tls"
      version = "3.0.0"
    }
  }
}

locals {
  location = "us-central1"
}

provider "random" {
  # Configuration options
}

provider "google" {
  # Configuration options
}

provider "tls" {
  # Configuration options
}

resource "random_integer" "project_id" {
  min = 1
  max = 1000
}

resource "google_project" "demo" {
  name       = "Demo Secure Web Proxy Demo Project"
  project_id = "prj-demo-swp-${random_integer.project_id.result}"
  billing_account = var.billing_id
  auto_create_network = false
}

resource "google_privateca_ca_pool" "demo" {
  name = "demo-ca-pool"
  location = local.location
  tier = "ENTERPRISE"
  publishing_options {
    publish_ca_cert = true
    publish_crl = true
  }
  labels = {
    demo = "swp"
  }
}

resource "google_privateca_certificate_authority" "demo" {
  location = local.location
  pool = google_privateca_ca_pool.demo.name
  certificate_authority_id = "demo-authority"
  config {
    subject_config {
      subject {
        organization = "DavidDTessier"
        common_name = "demo-authority"
      }
      subject_alt_name {
        dns_names = ["daviddtessier.ca"]
      }
    }
    x509_config {
      ca_options {
        is_ca = true
      }
      key_usage {
        base_key_usage {
          cert_sign = true
          crl_sign = true
        }
        extended_key_usage {
          server_auth = true
        }
      }
    }
  }
  key_spec {
    algorithm = "RSA_PKCS1_4096_SHA256"
  }

  // Disable CA deletion related safe checks for easier cleanup.
  deletion_protection                    = false
  skip_grace_period                      = true
  ignore_active_certificates_on_deletion = true
}

resource "tls_private_key" "cert_key" {
  algorithm = "RSA"
}

resource "google_privateca_certificate" "default" {
  location = local.location
  pool = google_privateca_ca_pool.default.name
  certificate_authority = google_privateca_certificate_authority.default.certificate_authority_id
  lifetime = "86000s"
  name = "cert-1"
  config {
    subject_config  {
      subject {
        common_name = "san1.daviddtessier.ca"
        country_code = "us"
        organization = "DavidDTessier"
        organizational_unit = "enterprise"
        locality = "mountain view"
        province = "california"
        street_address = "1600 amphitheatre parkway"
      } 
      subject_alt_name {
        email_addresses = ["david@daviddtessier.ca"]
        ip_addresses = ["127.0.0.1"]
        uris = ["http://www.ietf.org/rfc/rfc3986.txt"]
      }
    }
    x509_config {
      ca_options {
        is_ca = true
      }
      key_usage {
        base_key_usage {
          cert_sign = true
          crl_sign = true
        }
        extended_key_usage {
          server_auth = false
        }
      }
      name_constraints {
        critical                  = true
        permitted_dns_names       = ["*.daviddtessier.ca"]
        excluded_dns_names        = ["*.deny.daviddtessier.ca"]
        permitted_ip_ranges       = ["10.0.0.0/8"]
        excluded_ip_ranges        = ["10.1.1.0/24"]
        permitted_email_addresses = [".daviddtessier.ca"]
        excluded_email_addresses  = [".deny.example.com"]
        permitted_uris            = [".daviddtessier.ca"]
        excluded_uris             = [".deny.daviddtessier.ca"]
      }
    }
    public_key {
      format = "PEM"
      key = base64encode(tls_private_key.cert_key.public_key_pem)
    }
  }
}


resource "google_compute_network" "demo" {
  name                    = "demo-network"
  routing_mode            = "REGIONAL"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "demo" {
  name          = "demo-subnet"
  purpose       = "PRIVATE"
  ip_cidr_range = "10.128.0.0/20"
  region        = local.location
  network       = google_compute_network.demo.id
  role          = "ACTIVE"
  log_config {
    aggregation_interval = "INTERVAL_10_MIN"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_compute_subnetwork" "proxyonlysubnet" {
  name          = "demo-proxy-only-subnetwork"
  purpose       = "REGIONAL_MANAGED_PROXY"
  ip_cidr_range = "192.168.0.0/23"
  region        = local.location
  network       = google_compute_network.demo.id
  role          = "ACTIVE"
  log_config {
    aggregation_interval = "INTERVAL_10_MIN"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

resource "google_network_security_gateway_security_policy" "demo" {
  name        = "demo-policy-name"
  location    = local.location
}

resource "google_network_security_gateway_security_policy_rule" "demo" {
  name                    = "demo-policyrule-name"
  location                = local.location
  gateway_security_policy = google_network_security_gateway_security_policy.demo.name
  enabled                 = true  
  priority                = 1
  session_matcher         = "host() == 'daviddtessier.ca'"
  tls_inspection_enabled = true
  basic_profile           = "ALLOW"
}

resource "google_network_services_gateway" "demo" {
  name                                 = "demo-swp-gateway1"
  location                             = local.location
  addresses                            = ["10.128.0.99"]
  type                                 = "SECURE_WEB_GATEWAY"
  ports                                = [443]
  scope                                = "my-default-scope1"
  certificate_urls                     = [google_privateca_certificate_authority.demo.]
  gateway_security_policy              = google_network_security_gateway_security_policy.demo.id
  network                              = google_compute_network.demo.id
  subnetwork                           = google_compute_subnetwork.demo.id
  delete_swg_autogen_router_on_destroy = true
  depends_on                           = [google_compute_subnetwork.proxyonlysubnet]
}



