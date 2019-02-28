terraform {
  backend "gcs" {
    bucket = "desktop-environment"
    prefix = "terraform"
  }
}

provider "google" {
  project = "${var.gcp_project}"
  region = "${var.machine_region}"
}

locals {
  environment_name = "${var.DESKTOP_ENVIRONMENT_REGISTRY}-${var.DESKTOP_ENVIRONMENT_CONTAINER}"
}

resource "google_compute_instance" "desktop-environment" {
  allow_stopping_for_update = true
  machine_type = "${var.machine_type}"
  name = "${local.environment_name}"
  project = "${var.gcp_project}"
  tags = ["${local.environment_name}"]
  zone = "${var.machine_region}-a"

  boot_disk {
    initialize_params {
      image = "${local.environment_name}"
      type = "pd-ssd"
      size = "80"
    }
  }

  network_interface {
    access_config {
      nat_ip = "${google_compute_address.static.address}"
    }
    subnetwork = "${google_compute_subnetwork.desktop-environment.name}"
  }

  service_account {
    scopes = [
      "https://www.googleapis.com/auth/compute.readonly",
    ]
  }
}

resource "google_compute_firewall" "desktop-environment" {
  name = "${local.environment_name}"
  network = "${google_compute_network.desktop-environment.name}"

  allow {
    protocol = "icmp"
  }

  allow {
    ports = [
      "22",
      "80",
      "443",
    ]
    protocol = "tcp"
  }

  target_tags = ["${local.environment_name}"]
}

resource "google_compute_subnetwork" "desktop-environment" {
  name = "${local.environment_name}"
  ip_cidr_range = "10.2.0.0/16"
  network = "${google_compute_network.desktop-environment.name}"
  region = "${var.machine_region}"
}

resource "google_compute_network" "desktop-environment" {
  auto_create_subnetworks = false
  name = "${local.environment_name}"
}

resource "google_compute_address" "static" {
  name = "cloud-jacksondelahunt-com"
}

provider "cloudflare" {
  email = "${var.DESKTOP_ENVIRONMENT_CLOUDFLARE_EMAIL}"
  token = "${var.DESKTOP_ENVIRONMENT_CLOUDFLARE_TOKEN}"
}

resource "cloudflare_record" "desktop-environment" {
  domain = "${var.DESKTOP_ENVIRONMENT_CLOUDFLARE_DOMAIN}"
  name = "cloud"
  proxied = true
  type = "A"
  value = "${google_compute_address.static.address}"
}
