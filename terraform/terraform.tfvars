labels = {
  "project" = "slurm"
  "env"     = "lab"
}

### NETWORK
vpc_network_name = "backend-net"
vps_subnetworks = {
  "ru-central1-a" : ["172.20.0.0/27"],
  "ru-central1-b" : ["172.21.0.0/27"],
  "ru-central1-c" : ["172.22.0.0/27"],
}

### INSTANCES, GROUPS
instance_group_name = "nginx-group"
platform_id = "standard-v2"
resources = {
  disk          = 10
  cpu           = 2
  memory        = 1
  core_fraction = 20
  preemptible   = false
}
scale_count = 3

### SSH
public_ssh_key_path  = "~/.ssh/id_rsa.pub"
private_ssh_key_path = ""


### IMAGE FOR INSTANCES
image_name = "nginx"
image_tag  = 1

### LOADBALANCER
target_group_name  = "nginx-group"
backend_group_name = "nginx-backend"
loadbalancer_name  = "nginx-loadbalancer"
http_router_name   = "nginx-router"
virtual_host_name  = "nginx-virtual-host"
lb_frontend_port   = 443
http_backend_port  = 80





#cidr_blocks = [
#  ["172.20.0.0/27"],
#  ["172.21.0.0/27"],
#  ["172.22.0.0/27"],
#]