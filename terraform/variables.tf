variable "DESKTOP_ENVIRONMENT_CONTAINER" {
  description = "The DESKTOP_ENVIRONMENT_CONTAINER environment variable."
}

variable "DESKTOP_ENVIRONMENT_HOST_REPOSITORY" {
  description = "The DESKTOP_ENVIRONMENT_HOST_REPOSITORY environment variable."
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
  default = "custom-6-30720"
}

variable "owner_host" {
  description = "The hostname of the machine that created the instance."
  default = "owner-host"
}

variable "owner_name" {
  description = "The username of the user that created the instance."
  default = "owner-name"
}

variable "tls_cert_path" {
  description = "Path to file containing public TLS certificate."
  default = "~/.ssl/server.cert"
}

variable "tls_key_path" {
  description = "Path to file containing TLS private signing key."
  default = "~/.ssl/server.pem"
}

output "ip" {
  value = "${google_compute_instance.desktop-environment.network_interface.0.access_config.0.nat_ip}"
}
