resource "google_compute_instance" "default" {
  name         = "terraform-instance"
  machine_type = "e2-highmem-8"
  zone         = "us-central1-a"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
      size = 100
    }
  }

  network_interface {
    network = "default"
    access_config {
      // Ephemeral IP
    }
  }

  metadata_startup_script = "echo hi > /test.txt"
}

output "instance_ip" {
  value = google_compute_instance.default.network_interface[0].access_config[0].nat_ip
}