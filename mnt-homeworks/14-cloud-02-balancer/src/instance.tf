resource "yandex_vpc_network" "netology" {
name = "netology"
}

resource "yandex_vpc_subnet" "netology" {
  name           = var.vpc_name
  zone           = var.default_zone
  network_id     = yandex_vpc_network.netology.id
  v4_cidr_blocks = var.default_cidr
}

resource "yandex_iam_service_account" "ig-sa" {
  name        = "ig-sa"
}

resource "yandex_resourcemanager_folder_iam_member" "editor" {
  folder_id  = var.folder_id
  role       = "editor"
  member     = "serviceAccount:${yandex_iam_service_account.ig-sa.id}"
  depends_on = [
    yandex_iam_service_account.ig-sa,
  ]
}


resource "yandex_compute_instance_group" "group1" {
  name                = "test-ig"
  folder_id           = var.folder_id
  service_account_id  = "${yandex_iam_service_account.ig-sa.id}"
  deletion_protection = false
  instance_template {
    platform_id = "standard-v1"
    resources {
      memory = 2
      cores  = 2
    }
    boot_disk {
      mode = "READ_WRITE"
      initialize_params {
        image_id = "fd827b91d99psvq5fjit"
        size     = 4
      }
    }
    network_interface {
      network_id = yandex_vpc_network.netology.id
      subnet_ids = ["${yandex_vpc_subnet.netology.id}"]
    }

    metadata = {
      user-data: <<EOF
        #cloud-config
        runcmd:
          - sudo su
          - echo '<p><img src="https://storage.yandexcloud.net/${yandex_storage_bucket.ilshat.bucket}/${yandex_storage_object.ilshat.key}"></p>' > /var/www/html/index.html
          - ls -la > test
        EOF
      ssh-keys = "ubuntu:${local.server_ssh_key}"
    }
    network_settings {
      type = "STANDARD"
    }
  }


  scale_policy {
    fixed_scale {
      size = 3
    }
  }

  allocation_policy {
    zones = ["ru-central1-a"]
  }

  deploy_policy {
    max_unavailable = 2
    max_creating    = 3
    max_expansion   = 1
    max_deleting    = 3
  }


  health_check {
    interval = 5
    unhealthy_threshold    = 3
    http_options {
      port = 80
      path = "/"
    }
  }

  load_balancer {
    target_group_name        = "target-group"
    target_group_description = "load balancer target group"
  }

}