variable "instance_group_name" {
  type        = string
  description = "Name of the compute instance group"
}

variable "labels" {
  type        = map(string)
  description = "Labels to add to resources"
}

variable "vps_subnetworks" {
  type = map(list(string))
  default = {
    "ru-central1-a" : ["172.20.0.0/27"],
    "ru-central1-b" : ["172.21.0.0/27"],
    "ru-central1-c" : ["172.22.0.0/27"],
  }
  description = "Subnets in Availability Zones"
}

variable "platform_id" {
  type = string
  default = "standard-v2"
  description = "platform id"
  # https://cloud.yandex.ru/docs/compute/concepts/vm-platforms
}

variable "resources" {
  type = object({
    disk          = number
    cpu           = number
    memory        = number
    core_fraction = number
    preemptible   = bool
  })
  default = {
    disk          = 10
    cpu           = 2
    memory        = 2
    core_fraction = 100 # 5,20,50,100
    preemptible   = false
  }
  description = "VMs resources: CPU, Memory and Disk size"
}
 # https://cloud.yandex.ru/docs/compute/operations/vm-create/create-preemptible-vm

variable "public_ssh_key_path" {
  type        = string
  default     = ""
  description = "SSH keypair path"
}

variable "private_ssh_key_path" {
  type        = string
  default     = ""
  description = "SSH keypair path"
}

variable "scale_count" {
  type        = number
  description = "Number of VM to create"
}

variable "folder_id" {
  type        = string
  description = "Yandex Cloud Folder ID (exported from environment variables)"
}

variable "image_name" {
  type        = string
  description = "Image name"
}

variable "image_tag" {
  type        = number
  description = "Image tag"
}

variable "target_group_name" {
  type        = string
  description = "Application load balancer target group name"
}

variable "loadbalancer_name" {
  type        = string
  description = "Application load balancer name"
}

variable "http_router_name" {
  type        = string
  description = "Applictaion load balancer HTTP router name"
}

variable "backend_group_name" {
  type        = string
  description = "Application load balancer backend group name"
}

variable "virtual_host_name" {
  type        = string
  description = "Application load balancer virtual host name"
}

variable "lb_frontend_port" {
  type        = number
  description = "Application load balancer frontend port"
}

variable "http_backend_port" {
  type        = number
  description = "Application load balancer backend port"
}

variable "vpc_network_name" {
  type        = string
  description = "Virtual Private Cloud Network name"
}



#variable "az" {
#  type = list(string)
#  default = [
#    "ru-central1-a",
#    "ru-central1-b",
#    "ru-central1-c"
#  ]
#  description = "Availability Zones"
#}

#variable "cidr_blocks" {
#  type        = list(list(string))
#  description = "List of lists of IPv4 CIDR blocks for subnets"
#}

