provider "google" {
//  credentials = file(var.credentials_file)
  project = var.gcp_project
  region  = var.gcp_region
  zone = var.gcp_zone
}
/*
terraform {
  backend "gcs" {
    bucket = "devops-assignment"
    prefix = "terraform/state"
    credentials = var.credentials_file
  }
}
*/
