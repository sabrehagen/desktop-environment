provider "google" {
  credentials = "${file("${var.gcp_credentials_path}")}"
  project = "${var.gcp_project}"
}

resource "random_id" "instance_id" {
  byte_length = 2
}

locals {
  environment_name = "desktop-environment-${random_id.instance_id.hex}"
}

resource "google_compute_instance" "desktop-environment" {
  allow_stopping_for_update = true
  machine_type = "${var.machine_type}"
  name = "${local.environment_name}"
  project = "${var.gcp_project}"
  tags = ["desktop-environment"]
  zone = "${var.machine_region}-a"

  boot_disk {
    initialize_params {
      image = "stemnapp/desktop-environment"
      type = "pd-ssd"
      size = "80"
    }
  }

  network_interface {
    access_config {
      nat_ip = "35.201.14.140"
    }
    subnetwork = "${google_compute_subnetwork.desktop-environment.name}"
  }

  labels {
    owner-host = "${replace(lower(var.owner_host), "/[^a-z0-9-_]/", "")}"
    owner-name = "${replace(lower(var.owner_name), "/[^a-z0-9-_]/", "")}"
  }

  provisioner "remote-exec" {

    inline = [
      "# Start the X server",

      "# Clone and start the desktop environment",
      "git clone https://github.com/sabrehagen/desktop-environment",
      "desktop-environment/host/bootstrap.sh",

      "# Expose X server publicly with nginx",
      "desktop-environment/docker/scripts/exec.sh ~/.config/scripts/traefik.sh",
    ]
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
      "443",
    ]
    protocol = "tcp"
  }

  target_tags = ["desktop-environment"]
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
