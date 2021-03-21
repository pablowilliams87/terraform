provider "google" {
  credentials = var.credentials_file
  project     = var.gcp_project
  region      = var.gcp_region
  zone        = var.gcp_zone
}

terraform {
  required_version = "~> 0.14.0"
  required_providers {
    google = {
      version = ">= 3.60.0"
    }
  }
  backend "gcs" {
    bucket = "devops-assignment"
    prefix = "terraform/pwilliams-state"
  }
}

