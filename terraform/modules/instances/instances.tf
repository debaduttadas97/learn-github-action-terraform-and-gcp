resource "google_compute_instance" "vm_instance" {
  name         = "terraform-instance-00"
  machine_type = "f1-micro"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

network_interface {
  network = "default"
  access_config {
    }
  }
  
#Metadata for startup script to install Apache
metadata = {
    startup-script = <<-EOT
      #!/bin/bash
      sudo apt-get update
      sudo apt-get install -y apache2
      sudo systemctl start apache2
      sudo systemctl enable apache2
    EOT
  }

tags = ["http-server"]
}
#--------------------------------------------#
# Add a firewall rule to allow HTTP traffic
resource "google_compute_firewall" "default-allow-http" {
  name    = "default-allow-http"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }
  source_ranges = ["0.0.0.0/0"]
  target_tags = ["http-server"]
}
