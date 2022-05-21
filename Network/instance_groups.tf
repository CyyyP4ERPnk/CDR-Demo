resource "google_compute_instance_group" "eu-elastic-ig-zone-d" {
  name = "eu-elastic-ig-zone-d"
  network = google_compute_network.my-elastic-network.self_link
  instances = [
  google_compute_instance.my-elastic-instance-1.self_link,
  google_compute_instance.my-elastic-instance-2.self_link,]
  zone = var.region_zone_d
}

resource "google_compute_instance_group" "eu-elastic-ig-zone-c" {
  name = "eu-elastic-ig-zone-c"
  network = google_compute_network.my-elastic-network.self_link
  instances = [
  google_compute_instance.my-elastic-instance-3.self_link]
  zone = var.region_zone_c
}

resource "google_compute_instance_group" "eu-kibana-ig-zone-d" {
  name = "eu-kibana-ig-zone-d"
  network = google_compute_network.my-elastic-network.self_link
  instances = [google_compute_instance.my-elastic-kibana.self_link]
  named_port {
    name = "kibana"
    port = 8080
  }
  zone = var.region_zone_d
}