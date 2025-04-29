resource "google_compute_instance_template" "vm_instance_template" {
  name         = "terraform-instance-template-01"
  machine_type = "e2-medium"

  disk {
    auto_delete  = true
    boot         = true
    #source_image = "debian-cloud/debian-11"
    source_image = "projects/optical-figure-453316-a4/global/images/my-image-1"
  }

  network_interface {
    network = "default"

    access_config {
      # Ephemeral external IP address
    }
  }

  metadata = {
    startup-script = <<-EOT
      #!/bin/bash
        #sudo apt-get update
        #sudo apt-get install -y apache2
      echo "Hello world from $(hostname) $(hostname -i)" > /var/www/html/index.html
      sudo systemctl start apache2
      sudo systemctl enable apache2
    EOT
  }

  tags = ["http-server"]
}
