output "health_check_selflink_unique" {
  value = google_compute_health_check.default.self_link
}

output "instance_group_self_link" {
  value = google_compute_instance_group_manager.managed_group.instance_group
}
