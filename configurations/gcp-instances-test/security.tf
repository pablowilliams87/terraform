/*
resource "google_compute_firewall" "private_instance" {
  name    = "private-instance-firewall"
  network = google_compute_network.private_network.id

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_tags = ["bastion"]
}
*/