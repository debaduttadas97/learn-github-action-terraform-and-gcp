module "load-balancer_http-load-balancer" {
  source  = "gruntwork-io/load-balancer/google//modules/http-load-balancer"
  version = "0.2.1"
  # insert the 3 required variables here
    name = my-first-https-load-balancer
    project = var.project
    url_map = var.health_check_self_link
}
