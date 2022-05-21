resource "google_compute_instance" "elastic-instance-1" {
  name = "elastic-instance-1"
  machine_type = var.machine_type
  zone = var.region_zone_d
  allow_stopping_for_update = true
  tags = var.network_tags
  boot_disk {
    initialize_params {
    image = var.gce_image
    size = 200
    type = "pd-ssd"
    }
  }
  network_interface {
    subnetwork = google_compute_subnetwork.elastic-subnet.name
    network_ip = var.node_ips[0]
  }
  service_account {
    scopes = var.machine_access_scopes
    email = google_service_account.elastic-backup.email
  }
  metadata_startup_script = templatefile("./startup-elastic.sh", {
    node_name = var.master_node,
    network_host = var.node_ips[0],
    elastic_host_1 = var.node_ips[0],
    elastic_host_2 = var.node_ips[1],
    elastic_host_3 = var.node_ips[2],
    master_node = var.master_node,
    ca_bucket = var.ca_bucket_location,
    backup_bucket = var.backup_bucket,
    gcp_sa = google_service_account_key.mykey.private_key,
    elastic_pw = var.elastic_pw, 
  })
}
