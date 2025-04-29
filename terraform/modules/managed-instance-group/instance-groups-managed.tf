# Reference an existing instance template
resource "google_compute_instance_group_manager" "managed_group" {
  name               = "terraform-managed-instance-group01"
  base_instance_name = "terraform-managed-instance-group01-instance"
  instance_template  = "projects/learn-terraform-457917/global/instanceTemplates/terraform-instance-template-01"
  target_size        = 2
  zone               = var.zone

  auto_healing_policies {
    health_check      = google_compute_health_check.default.self_link
    initial_delay_sec = 300
  }
}

resource "google_compute_health_check" "default" {
  name               = "mig-health-check"
  check_interval_sec = 10
  timeout_sec        = 5
  healthy_threshold  = 2
  unhealthy_threshold = 2

  http_health_check {
    request_path = "/"
    port         = 80
  }
}
