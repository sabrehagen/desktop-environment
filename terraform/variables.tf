variable "DESKTOP_ENVIRONMENT_CLOUDFLARE_DOMAIN" {
  description = "The DESKTOP_ENVIRONMENT_CLOUDFLARE_DOMAIN environment variable."
}

variable "DESKTOP_ENVIRONMENT_CLOUDFLARE_EMAIL" {
  description = "The DESKTOP_ENVIRONMENT_CLOUDFLARE_EMAIL environment variable."
}

variable "DESKTOP_ENVIRONMENT_CLOUDFLARE_TOKEN" {
  description = "The DESKTOP_ENVIRONMENT_CLOUDFLARE_TOKEN environment variable."
}

variable "DESKTOP_ENVIRONMENT_CONTAINER" {
  description = "The DESKTOP_ENVIRONMENT_CONTAINER environment variable."
}

variable "DESKTOP_ENVIRONMENT_REGISTRY" {
  description = "The DESKTOP_ENVIRONMENT_REGISTRY environment variable."
}

variable "gcp_project" {
  description = "The project to create the machine in."
  default = "stemnapp"
}

variable "machine_region" {
  description = "The zone to create the machine in."
  default = "australia-southeast1"
}

variable "machine_type" {
  description = "The machine type."
  default = "custom-6-16384"
}

output "ip" {
  value = "${google_compute_instance.desktop-environment.network_interface.0.access_config.0.nat_ip}"
}
