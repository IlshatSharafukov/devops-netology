

resource "yandex_alb_backend_group" "cat" {
  name                     = "cat"

  http_backend {
    name                   = "cat"
    weight                 = 1
    port                   = 80
    target_group_ids       = ["${yandex_compute_instance_group.group1.application_load_balancer.0.target_group_id}"]
    load_balancing_config {
      panic_threshold      = 90
    }
    healthcheck {
      timeout              = "10s"
      interval             = "2s"
      healthy_threshold    = 10
      unhealthy_threshold  = 15
      http_healthcheck {
        path               = "/"
      }
    }
  }
}

resource "yandex_alb_http_router" "tf-router" {
  name   = "cat"
}

resource "yandex_alb_virtual_host" "my-virtual-host" {
  name           = "cat"
  http_router_id = yandex_alb_http_router.tf-router.id
  route {
    name = "cat"
    http_route {
      http_match {
      }
      http_route_action {
        backend_group_id = yandex_alb_backend_group.cat.id
        timeout          = "60s"
      }
    }
  }
}


resource "yandex_alb_load_balancer" "balancer" {
  name = "balancerl7"
  network_id  = yandex_vpc_network.netology.id

  allocation_policy {
    location {
      zone_id   = "ru-central1-a"
      subnet_id = yandex_vpc_subnet.netology.id
    }
  }

  listener {
    name = "cat"
    endpoint {
      address {
        external_ipv4_address {
        }
      }
      ports = [ 80 ]
    }
    http {
      handler {
        http_router_id = yandex_alb_http_router.tf-router.id
      }
    }
  }
}
