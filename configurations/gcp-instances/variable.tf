variable "credentials_file" {
  description = "GCP Credentials File"
}

variable "gcp_project" {
  description = "GCP Project"
  default     = "evbox-infrastructure"
}

variable "gcp_zone" {
  description = "GCP Zone"
  default     = "europe-west1-d"
}

variable "gcp_region" {
  description = "GCP Region"
  default     = "europe-west1"
}

variable "gcp_machine_type" {
  description = "GCP Machine Type"
  default     = "e2-medium"
}

variable "gcp_instance_image" {
  description = "GCP Instance Image"
  default     = "debian-cloud/debian-10"
}

variable "gcp_ssh_user" {
  description = "GCP Instance Private Key"
  default     = "evbox-infrastructure"
}

variable "gcp_ssh_public_key" {
  description = "GCP Instance SSH Public Key"
}

variable "gcp_ssh_private_key" {
  description = "GCP Instance Private Key"
}
