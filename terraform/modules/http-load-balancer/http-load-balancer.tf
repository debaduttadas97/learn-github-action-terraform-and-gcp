#module "load-balancer_http-load-balancer" {
#  source  = "gruntwork-io/load-balancer/google//modules/http-load-balancer"
#  version = "0.2.1"
# insert the 3 required variables here
#    name = my-first-https-load-balancer
#    project = var.project
#    url_map = var.health_check_self_link
#}


# Global static IP
resource "google_compute_global_address" "default" {
  name = "http-lb-ip"
}

# Health check
#resource "google_compute_health_check" "default" {
#  name = "http-health-check"
#  http_health_check {
#    port = 80
# }
#}

# Backend service using MIG
resource "google_compute_backend_service" "default" {
  name                  = "http-backend-service"
  protocol              = "HTTP"
  port_name             = "http"
  load_balancing_scheme = "EXTERNAL"
  timeout_sec           = 10
  health_checks         = [var.health_check_self_link]

  backend {
    group = var.instance_group
  }
}

# URL map
resource "google_compute_url_map" "default" {
  name            = "http-url-map"
  default_service = google_compute_backend_service.default.self_link
}

# Target HTTP proxy
resource "google_compute_target_http_proxy" "default" {
  name    = "http-proxy"
  url_map = google_compute_url_map.default.self_link
}

# Global forwarding rule
resource "google_compute_global_forwarding_rule" "default" {
  name                  = "http-forwarding-rule"
  ip_address            = google_compute_global_address.default.address
  port_range            = "80"
  target                = google_compute_target_http_proxy.default.self_link
  load_balancing_scheme = "EXTERNAL"
}
