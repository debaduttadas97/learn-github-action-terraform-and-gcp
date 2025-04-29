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
