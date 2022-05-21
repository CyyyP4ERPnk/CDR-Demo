resource "google_compute_region_backend_service" "elastic-internal-lb-i" {
  name = "elastic-internal-lb-i"
  load_balancing_scheme = "INTERNAL"
  health_checks = [google_compute_health_check.my-tcp-health-check.self_link]
  region = var.region
  backend {
   group = google_compute_instance_group.eu-elastic-ig-zone-d.self_link
  }
  backend {
   group = google_compute_instance_group.eu-elastic-ig-zone-c.self_link
  }
}

resource "google_compute_forwarding_rule" "elastic-internal-lb-i-forwarding-rule" {
  name = "elastic-internal-lb-i-forwarding-rule"
  load_balancing_scheme = "INTERNAL"
  ports = var.ports_to_open
  network = google_compute_network.my-elastic-network.self_link
  subnetwork = google_compute_subnetwork.my-elastic-subnet.self_link
  backend_service = google_compute_region_backend_service.elastic-internal-lb-i.self_link
  ip_address = var.internal_lb_ip
}

resource "google_compute_health_check" "my-tcp-health-check" {
  name = "my-tcp-health-check"
  description = "Health check via tcp"
  check_interval_sec = 300
  timeout_sec = 300
  tcp_health_check {
    port = "9200"
    proxy_header = "NONE"
    response = "name"
  }
}