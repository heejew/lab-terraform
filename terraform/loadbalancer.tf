resource "yandex_alb_target_group" "this" {
  name      = "${local.resource_name}-${var.target_group_name}"
  labels = var.labels

  dynamic "target" {
    for_each = yandex_compute_instance_group.this.instances
    content {
      subnet_id = target.value.network_interface.0.subnet_id
      ip_address   = target.value.network_interface.0.ip_address
    }
  }
}

resource "yandex_alb_backend_group" "this" {
  name = "${local.resource_name}-${var.backend_group_name}"
  labels = var.labels

  http_backend {
    name             = var.backend_group_name
    weight           = 1
    port             = var.http_backend_port
    target_group_ids = [yandex_alb_target_group.this.id]
    load_balancing_config {
      panic_threshold = 50
    }
    healthcheck {
      timeout  = "1s"
      interval = "1s"
      healthcheck_port = var.http_backend_port
      http_healthcheck {
        path = "/"
      }
    }
  }
}

resource "yandex_alb_load_balancer" "this" {
  name        = "${local.resource_name}-${var.loadbalancer_name}"
  labels = var.labels

  network_id  = yandex_vpc_network.this.id

  allocation_policy {
    dynamic "location" {
      for_each = toset(var.az)
      content {
        zone_id   = location.value
        subnet_id = yandex_vpc_subnet.this[location.value].id
      }
    }
  }

  listener {
    name = "my-listener"
    endpoint {
      address {
        external_ipv4_address {
        }
      }
      ports = [ var.lb_frontend_port ]
    }
    http {
      handler {
        http_router_id = yandex_alb_http_router.this.id
      }
    }
  }

  log_options {
    discard_rule {
      http_code_intervals = ["HTTP_2XX"]
      discard_percent = 75
    }
  }
}

resource "yandex_alb_http_router" "this" {
  name      = "${local.resource_name}-${var.http_router_name}"
  labels = var.labels
}

resource "yandex_alb_virtual_host" "this" {
  name      = "${local.resource_name}-${var.virtual_host_name}"
  http_router_id = yandex_alb_http_router.this.id
  route {
    name = "my-route"
    http_route {
      http_route_action {
        backend_group_id = yandex_alb_backend_group.this.id
        timeout = "3s"
      }
    }
  }
}