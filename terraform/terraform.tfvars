instance_group_name = "nginx-group"

labels = {
  "project" = "slurm"
  "env"     = "lab"
}

cidr_blocks = [
  ["172.20.0.0/27"],
  ["172.21.0.0/27"],
  ["172.22.0.0/27"],
]

resources = {
  disk = 10
  cpu = 1
  memory = 2
  core_fraction = 20
}

public_ssh_key_path = ""
private_ssh_key_path = ""

scale_count = 3

image_name = "nginx"
image_tag = 1

target_group_name = "nginx-group"
backend_group_name = "nginx-backend"
loadbalancer_name = "nginx-loadbalancer"
http_router_name = "nginx-router"
virtual_host_name = "nginx-virtual-host"
lb_frontend_port = 443
http_backend_port = 80

vpc_network_name = "backend-net"