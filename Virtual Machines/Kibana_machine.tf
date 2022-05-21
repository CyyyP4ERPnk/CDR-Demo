resource "google_compute_instance" "my-elastic-kibana" {
  name = "my-elastic-kibana"
  machine_type = var.machine_type_medium
  zone = var.region_zone_d
  tags = var.kibana_tags
  allow_stopping_for_update = true
  boot_disk {
    initialize_params {
      image = var.gce_image
      size = 100
    }
  }
  network_interface {
    subnetwork = google_compute_subnetwork.my-elastic-subnet.name
    network_ip = "ip within your subnet range"
  }
  service_account {
    scopes = var.machine_access_scopes
  }
  metadata_startup_script = templatefile("./startup-kibana.sh", {
    elastic_host_1 = var.node_ips[0],
    elastic_host_2 = var.node_ips[1],
    elastic_host_3 = var.node_ips[2],
    elastic_pw = var.elastic_pw,
    internal_lb_ip = var.internal_lb_ip,
    ca_bucket = var.ca_bucket_location,
    gcp_sa = google_service_account_key.mykey.private_key 
    })
}