resource "yandex_compute_instance" "node01" {
  count = 2
  name                      = "node0${count.index}"
  zone                      = "ru-central1-a"
  hostname                  = "node0${count.index}.netology.cloud"
  allow_stopping_for_update = true

  scheduling_policy {
    preemptible = "true"
  }
  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id    = "${var.ubuntu-2204-lts}"
      name        = "root-node0${count.index}"
      type        = "network-nvme"
      size        = "50"
    }
  }

  network_interface {
    subnet_id = "e9bc25phf4ek20tldkgs"
    nat       = true
  }

  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
  }
}