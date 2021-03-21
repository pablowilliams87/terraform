variable "credentials_file" {
  description = "GCP Credentials File"
}

variable "gcp_project" {
  description = "GCP Project"
  default = "playground-s-11-6e326de5"
}

variable "gcp_zone" {
  description = "GCP Zone"
  default = "europe-west1-d"
}

variable "gcp_region" {
  description = "GCP Region"
  default = "europe-west1"
}

variable "gcp_machine_type" {
  description = "GCP Machine Type"
  default = "e2-medium"
}

variable "gcp_instance_image" {
  description = "GCP Instance Image"
  default = "debian-cloud/debian-10"
}

variable "gcp_ssh_user" {
  description = "GCP Instance Private Key"
  default = "pwilliams"
}

variable "gcp_ssh_pk" {
  description = "GCP Instance Private Key"
  default = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCfW21z0xc7gC4/xQBkB1KKBQa3Ox4HWK8Pheu5x+LOQxC6F5frBv8eSd81L5s8k3jRllZWswwEx+ZmfrCkVE5fy86l8II9+FV0wjaohpL3zpOJybUDbH8d+YjrrRcLWfUNVBmhCzF+gDxvBHT9TFW3OCIHqHtfM4UHD89kOx22+o37H/KWdXq4gSan2Z6cju16RH0bqOlXehMTPpPaDr+4c2TfTNBtCBsCO/niktQgq62lKIrJQ05Kh1v9STBqZidzwPmIpJLe+If4uGxk4UM5QnzrcS5+jKcSSWvGZZfeat29aGCyNpfd7wBH7+iiSzmcU4/rKCiv7ByzCBTc+qrp pablow@DESKTOP-K7SL4LU"
}