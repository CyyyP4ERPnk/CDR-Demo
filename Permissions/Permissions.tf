resource "google_project_iam_custom_role" "elastic-backup" {
  role_id = "Custom-elastic-role"
  title = "Elastic role"
  description = "Role for serviceaccounts used by elastic-vms"
  permissions = ["iam.serviceAccountKeys.get","storage.objects.get","storage.buckets.get","storage.buckets.create","storage.objects.create","storage.objects.list","storage.objects.delete"]
}

resource "google_project_iam_member" "elastic-backup" {
  role = "projects/${var.project_name}/roles/Custom-elastic-role"
  member = "serviceAccount:elastic-backup@${var.project_name}.iam.gserviceaccount.com"
}

resource "google_service_account" "elastic-backup" {
  account_id = "elastic-backup"
  display_name = "Service account for elastic VMs"
}

resource "google_service_account_key" "mykey" {
  service_account_id = google_service_account.elastic-backup.name
}