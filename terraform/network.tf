
module "network_subnets" {
  source = "./network"
  name_prefix = local.resource_name
  network_name = var.vpc_network_name
#  az = local.list_az
  labels = var.labels
#  cidr_blocks = local.list_subnet
  vps_subnetworks = var.vps_subnetworks
}

# Перенесено в модуль.))
#resource "yandex_vpc_network" "this" {
#  name   = "${local.resource_name}-${var.vpc_network_name}"
#  labels = var.labels
#}
#
#resource "yandex_vpc_subnet" "this" {
#  for_each       = toset(var.az)
#  name           = "${local.resource_name}-${each.value}"
#  v4_cidr_blocks = var.cidr_blocks[index(var.az, each.value)]
#  zone           = each.value
#  network_id     = yandex_vpc_network.this.id
#  labels         = var.labels
#}