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
      image = "ubuntu-minimal-1810"
      type = "pd-ssd"
      size = "80"
    }
  }

  network_interface {
    access_config { } # Creates ephemeral IP
    subnetwork = "${google_compute_subnetwork.desktop-environment.name}"
  }

  labels {
    owner-host = "${replace(lower(var.owner_host), "/[^a-z0-9-_]/", "")}"
    owner-name = "${replace(lower(var.owner_name), "/[^a-z0-9-_]/", "")}"
  }

  metadata {
    ssh-keys = "root:${file("${var.public_key_path}")}"
  }

  provisioner "remote-exec" {
    connection {
      type = "ssh"
      user = "root"
      private_key = "${file("${var.private_key_path}")}"
      agent = false
    }

    inline = [
      "# Install docker",
      "apt-get update -qq && apt-get install -qq docker.io",

      "# Supply docker daemon configuration using stemn certificates",
      "echo '${file("${var.docker_config_path}")}' > /etc/docker/daemon.json",
      "echo '${file("${var.tls_ca_cert_path}")}' > /etc/docker/ca.crt",
      "echo '${file("${var.tls_cert_path}")}' > /etc/docker/server.crt",
      "echo '${file("${var.tls_key_path}")}' > /etc/docker/server.key",

      "# Override default docker daemon config",
      "mkdir -p /etc/systemd/system/docker.service.d",
      "printf '[Service]\nExecStart=\nExecStart=/usr/bin/dockerd' > /etc/systemd/system/docker.service.d/override.conf",
      "systemctl daemon-reload && service docker restart",

      "# Make the docker socket accessible to the docker group",
      "chown :999 /var/run/docker.sock",

       "# Supply stemn certificates to ubuntu certificate store",
      "echo '${file("${var.tls_ca_cert_path}")}' > /usr/local/share/ca-certificates/desktop-environment.crt",
      "update-ca-certificates",
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
      "80",
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
