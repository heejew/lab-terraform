## Да, наркомания, просто модули тестировал x)
terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
    tls = {
      source = "hashicorp/tls"
      version = "4.0.4"
    }
  }
  required_version = ">= 0.13"
}


resource "yandex_vpc_network" "this" {
  name   = "${var.name_prefix}-${var.network_name}"
  labels = var.labels
}

resource "yandex_vpc_subnet" "this" {
  for_each       = toset(flatten(tolist(keys(var.vps_subnetworks))))
  name           = "${var.name_prefix}-${each.value}"
  v4_cidr_blocks = lookup(var.vps_subnetworks,each.value)
  zone           = each.value
  network_id     = yandex_vpc_network.this.id
  labels         = var.labels
}

output "network" {
  value = yandex_vpc_network.this.id
}

output "subnets" {
  value = yandex_vpc_subnet.this
#   value = [for s in yandex_vpc_subnet.this : s.website_endpoint[*]]
#   value = values(yandex_vpc_subnet.this)
}
