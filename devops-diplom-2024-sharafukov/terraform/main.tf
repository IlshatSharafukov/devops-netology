
data "yandex_compute_image" "image" {
  family = var.image_family
}
resource "yandex_compute_instance" "kube_node" {
  count =   length(var.num_node)
  name        = var.num_node[count.index]
  allow_stopping_for_update = true
  resources {
    cores         = var.num_node[count.index] == "vm-control-node" ? var.vm-control-node.cores : var.vm-worker-node.cores
    memory        = var.num_node[count.index] == "vm-control-node" ? var.vm-control-node.memory : var.vm-worker-node.memory
    core_fraction = var.num_node[count.index] == "vm-control-node" ? var.vm-control-node.core_fraction : var.vm-worker-node.core_fraction
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.image.image_id
      type        = "network-hdd"
      size        = "10"
    }
  }
  scheduling_policy {
    preemptible = true
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.project[0].id
    nat       = true
  }

  metadata = {
    serial-port-enable = "1"
    ssh-keys           = "centos:${local.server_ssh_key}"
  }
}



resource "local_file" "hosts_cfg" {
  depends_on = [yandex_compute_instance.kube_node]
  content = templatefile("/home/ruasfih/diplom/devops-diplom-2024-sharafukov/YC-terraform/hosts.tftpl",

    { kube_node =  yandex_compute_instance.kube_node}  )

  filename = "/home/ruasfih/diplom/devops-diplom-2024-sharafukov/YC-terraform/hosts.ini"
}


resource "null_resource" "hosts_provision" {
  depends_on = [yandex_compute_instance.kube_node]


  provisioner "local-exec" {
    command = "sleep 30"
  }

  provisioner "local-exec" {
      command  = "export ANSIBLE_HOST_KEY_CHECKING=False; cd /home/ruasfih/diplom/devops-diplom-2024-sharafukov/kubespray; ansible-playbook -i /home/ruasfih/diplom/devops-diplom-2024-sharafukov/YC-terraform/hosts.ini -b --diff cluster.yml"
      on_failure = continue
      environment = { ANSIBLE_HOST_KEY_CHECKING = "False" }
    }
}