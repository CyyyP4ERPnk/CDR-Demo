resource "google_compute_firewall" "allow-all-internal" {
  name = "allow-all-internal"
  network = google_compute_network.my-elastic-network.name
  allow {
    protocol = "tcp"
  }
  allow {
    protocol = "udp"
  }
  allow {
    protocol = "icmp"
  }
  source_ranges = ["x.x.x.x/x"] // your subnet IP range
}

resource "google_compute_firewall" "allow-internal-lb" {
  name = "allow-internal-lb"
  network = google_compute_network.my-elastic-network.name
  allow {
    protocol = "tcp"
    ports = var.ports_to_open
  }
  source_ranges = ["x.x.x.x/x"] // your subnet IP range
  target_tags = var.network_tags
}

resource "google_compute_firewall" "allow-health-check" {
  name = "allow-health-check"
  network = google_compute_network.my-elastic-network.name
  allow {
    protocol = "tcp"
    ports = var.ports_to_open
  }
  source_ranges = ["x.x.x.x/x"] // your subnet IP range
  target_tags = var.network_tags
}