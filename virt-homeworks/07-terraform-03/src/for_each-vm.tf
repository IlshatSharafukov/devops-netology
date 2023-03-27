resource "yandex_compute_instance" "compute_instance_home-work-for-each" {
  depends_on = [yandex_compute_instance.compute_instance_home-work-count, yandex_compute_disk.disk] 

  for_each = var.for_each_hw

  name                      = "terraform-homework-each-loop-${each.value.name_prefix}"
  zone                      = "ru-central1-a"
  hostname                  = "terraform-homework-${each.value.name_prefix}.netology.cloud"
  allow_stopping_for_update = true

  resources {
    cores  = each.value.cpu
    memory = each.value.mem
  }

  scheduling_policy {
    preemptible = true
  }

  boot_disk {
    initialize_params {
      image_id    = "${var.centos-7}"
      name        = "terraform-homework-${each.value.name_prefix}"
      type        = "network-hdd"
      size        = each.value.disk_size
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = true
    security_group_ids = toset([yandex_vpc_security_group.example.id])
  }

  metadata = {
    ssh-keys = "centos:${local.ssh_key}"
  }
}
