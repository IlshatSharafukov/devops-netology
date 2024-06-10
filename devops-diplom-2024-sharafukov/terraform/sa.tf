resource "yandex_iam_service_account" "sa" {
  folder_id = var.folder_id
  name      = var.sa_name
}


resource "yandex_resourcemanager_folder_iam_member" "sa-editor" {
  folder_id = var.folder_id
  role      = "storage.editor"
  member    = "serviceAccount:${yandex_iam_service_account.sa.id}"
}


resource "yandex_iam_service_account_static_access_key" "sa-static-key" {
  service_account_id = yandex_iam_service_account.sa.id
  description        = "static access key for object storage"
}


resource "yandex_kms_symmetric_key" "key-a" {
  name              = var.key_name
  description       = "key for sa"
  default_algorithm = "AES_128"
  rotation_period   = "8760h"}
