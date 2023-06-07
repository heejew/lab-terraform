locals {
  loadbalancer_external_ip = tolist(tolist(tolist(tolist(yandex_alb_load_balancer.this.listener).0.endpoint).0.address).0.external_ipv4_address).0.address
}

resource "null_resource" "check_alb" {
  depends_on = [
    yandex_alb_load_balancer.this,
    local.loadbalancer_external_ip
  ]
  provisioner "local-exec" {
    command = "curl ${local.loadbalancer_external_ip}:443 -i"
  }
}
