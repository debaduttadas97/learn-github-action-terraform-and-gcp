variable "mig-zone" {
 type= string
 default= "us-central1-a"
 description = "Default ZONE for Managed Instance Group"
}
variable "instance_template_self_link" {
  description = "The self_link of the instance template to use for the managed instance group"
  type        = string
}
