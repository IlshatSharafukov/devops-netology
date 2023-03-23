resource "local_file" "hosts_cfg" {
  content = templatefile("${path.module}/hosts.tftpl",

    {disk_vm =  yandex_compute_instance.compute_instance_home-work-disk_add,
    each_vm =  yandex_compute_instance.compute_instance_home-work-for-each,
    count_vm =  yandex_compute_instance.compute_instance_home-work-count} )

  filename = "${abspath(path.module)}/hosts.cfg"
}