resource "yandex_compute_disk" "disk" {
  count = 3
  name     = "homework-disk-0${count.index}"
  type     = "network-hdd"
  zone     = "ru-central1-a"
  size     = "1"
}

resource "yandex_compute_instance" "compute_instance_home-work-disk_add" {
  count = 1
  name                      = "terraform-homework-disk-${count.index}"
  zone                      = "ru-central1-a"
  hostname                  = "terraform-homework-disk-${count.index}.netology.cloud"
  allow_stopping_for_update = true
  
  dynamic "secondary_disk" {
    for_each = yandex_compute_disk.disk
    content {
      disk_id  = secondary_disk.value.id
    }
  }

  resources {
    cores  = 2
    memory = 2
  }

  scheduling_policy {
    preemptible = true
  }

  boot_disk {
    initialize_params {
      image_id    = "${var.centos-7}"
      name        = "terraform-homework-disk-${count.index}"
      type        = "network-hdd"
      size        = "10"
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = true
  }

  metadata = {
    ssh-keys = "centos:${local.ssh_key}"
  }
}
