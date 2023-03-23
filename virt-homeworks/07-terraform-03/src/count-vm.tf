resource "yandex_compute_instance" "compute_instance_home-work-count" {
  count = 2
  name                      = "terraform-homework-${count.index}"
  zone                      = "ru-central1-a"
  hostname                  = "terraform-homework-${count.index}.netology.cloud"
  allow_stopping_for_update = true

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
      name        = "terraform-homework-${count.index}"
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
