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
  }
  
#network_interface {
  #  network = google_compute_network.vpc_network.name
  #  access_config {
  #  }
  #}
}
