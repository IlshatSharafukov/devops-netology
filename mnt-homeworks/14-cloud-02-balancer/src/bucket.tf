resource "yandex_storage_bucket" "ilshat" {
  access_key = yandex_iam_service_account_static_access_key.sa-static-key.access_key
  secret_key = yandex_iam_service_account_static_access_key.sa-static-key.secret_key
  bucket = "ilshat01"
  acl    = "public-read"
}

resource "yandex_storage_object" "ilshat" {
  bucket = "ilshat01"
  key    = "cat.jpg"
  access_key = yandex_iam_service_account_static_access_key.sa-static-key.access_key
  secret_key = yandex_iam_service_account_static_access_key.sa-static-key.secret_key
  source = "cat.jpg"
}


resource "yandex_iam_service_account" "sa" {
  folder_id = var.folder_id
  name      = "sa123"
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