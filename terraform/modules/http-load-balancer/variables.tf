variable  "health_check_self_link" {
    type = string
    description = "Managed Instance group health_check self_link"
}

variable "instance_group" {
  description = "The self_link of the instance group"
  type        = string
}
