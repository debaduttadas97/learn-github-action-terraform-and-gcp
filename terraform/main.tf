terraform {
    backend "gcs" { 
      bucket  = "learn-github-action-terraform-and-gcp"
      prefix  = "demo"
    }
}

provider "google" {
  project = var.project
  region = var.region
  zone = var.zone
}

#module "instances" {
#  source     = "./modules/instances"
#}

module "firewalls" {
    source    = "./modules/firewalls"
}

module "instance-template" {
    source    = "./modules/instance-template"
}

module "managed-instance-group" {
    source    = "./modules/managed-instance-group"
    instance_template_self_link    = instance-template.google_compute_instance_template.vm_instance_template.self_link
}
