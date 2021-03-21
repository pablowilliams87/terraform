resource "google_compute_instance" "private_instance" {
  name                      = "private-instance"
  machine_type              = var.gcp_machine_type
  allow_stopping_for_update = true
  tags                      = ["private"]

  service_account {
    email  = "devops-assignment-evbox@evbox-infrastructure.iam.gserviceaccount.com"
    scopes = ["cloud-platform"]
  }

  metadata = {
    ssh-keys = "${var.gcp_ssh_user}:${file(var.gcp_ssh_public_key)}"
  }

  boot_disk {
    initialize_params {
      image = var.gcp_instance_image
    }
  }

  network_interface {
    network = "default"
  }
}


resource "google_compute_address" "public_ip" {
  name         = "public-address"
  address_type = "EXTERNAL"
}


resource "google_compute_instance" "public_instance" {
  name                      = "public-instance"
  machine_type              = var.gcp_machine_type
  allow_stopping_for_update = true
  tags                      = ["public", "bastion"]

  service_account {
    email  = "devops-assignment-evbox@evbox-infrastructure.iam.gserviceaccount.com"
    scopes = ["cloud-platform"]
  }

  metadata = {
    ssh-keys = "${var.gcp_ssh_user}:${file(var.gcp_ssh_public_key)}"
  }
  
  metadata_startup_script = "echo '${file(var.gcp_ssh_private_key)}' > /tmp/id_rsa"

  boot_disk {
    initialize_params {
      image = var.gcp_instance_image
    }
  }

  network_interface {
    network = "default"
    access_config {
      nat_ip = google_compute_address.public_ip.address
    }

  }
}
