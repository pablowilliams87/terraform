resource "google_compute_address" "public_ip" {
  name         = "public-address"
  address_type = "EXTERNAL"
//  region       = var.gcp_region
}


resource "google_compute_instance" "public_instance" {
  name         = "public-instance"
  machine_type = var.gcp_machine_type
//  zone         = var.gcp_zone
  allow_stopping_for_update = true
  tags = ["public", "bastion"]
/*
  metadata = {
    ssh-keys = "${var.gcp_ssh_user}:${var.gcp_ssh_pk}"
 //   enable-oslogin = "TRUE"
  }
*/
  service_account {
    email = "546475101017-compute@developer.gserviceaccount.com"
    scopes = [ "cloud-platform" ]
  }

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


resource "google_compute_instance" "private_instance" {
  name         = "private-instance"
  machine_type = var.gcp_machine_type
//  zone         = var.gcp_zone
  allow_stopping_for_update = true
  tags = ["private"]

  service_account {
    email = "546475101017-compute@developer.gserviceaccount.com"
    scopes = [ "cloud-platform" ]
  }

/*
  metadata = {
    ssh-keys = "${var.gcp_ssh_user}:${var.gcp_ssh_pk}"
    enable-oslogin = "TRUE"
  }
*/
  boot_disk {
    initialize_params {
      image = var.gcp_instance_image
    }
  }

  network_interface {
    network = "default"
  }
}

