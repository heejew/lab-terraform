resource "yandex_iam_service_account" "this" {
  name        = "vmmanager"
  description = "service account to manage VMs"
}

resource "yandex_resourcemanager_folder_iam_binding" "this" {
  folder_id = var.folder_id
  role = "editor"
  members = [
    "serviceAccount:${yandex_iam_service_account.this.id}",
  ]
}