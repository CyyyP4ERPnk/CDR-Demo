resource "google_compute_network" "my-elastic-network" {
  name = "${var.project_name}-elastic-vpc"
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "my-elastic-subnet" {
  name = "my-elastic-subnet"
  ip_cidr_range = "select a range in your region"
  network = google_compute_network.my-elastic-network.self_link
  region = var.region
  private_ip_google_access = true
  log_config {
    aggregation_interval = "INTERVAL_10_MIN"
    flow_sampling = 0.5
    metadata = "INCLUDE_ALL_METADATA"
  }
}