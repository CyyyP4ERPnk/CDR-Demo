resource "google_compute_router_nat" "elastic-nat" {
  name = "elastic-router-nat"
  router = google_compute_router.elastic-router.name
  region = var.region
  nat_ip_allocate_option = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "LIST_OF_SUBNETWORKS"
  subnetwork {
   name = google_compute_subnetwork.my-elastic-subnet.namesource_ip_ranges_to_nat = ["ALL_IP_RANGES"]
  }
  log_config {
    enable = true
    filter = "ALL"
  }
}

resource "google_compute_router" "elastic-router" {
  name = "elastic-router"
  region = var.region
  network = google_compute_network.my-elastic.network.self_link
  bgp {
    asn = 64514
  }
}