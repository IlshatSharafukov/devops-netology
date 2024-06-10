resource "yandex_vpc_network" "project" {
  name = var.vpc_name
}


resource "yandex_vpc_subnet" "project" {
  count =   length(var.subnet_name)
  name           = var.subnet_name[count.index]
  zone           = var.zone[count.index]
  network_id     = yandex_vpc_network.project.id
  v4_cidr_blocks = [var.subnet_cidrs[count.index]]
}

output "vpc" {
  value = yandex_vpc_network.project
}

output "subnet" {
  value = yandex_vpc_subnet.project
}