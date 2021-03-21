output "public_instance_ip" {
  value = google_compute_address.public_ip.address
}

output "private_instance_ip" {
  value = google_compute_instance.private_instance.network_interface[0].network_ip
}