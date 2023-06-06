

packer {
  required_plugins {
    yandex = {
      version = ">= 1.1.2"
      source  = "github.com/hashicorp/yandex"
    }
  }
}




source "yandex" "nginx" {
  source_image_family = var.source_image_family
  ssh_username        = var.ssh_username
  use_ipv4_nat        = var.use_ipv4_nat
  image_description   = var.image_description
  image_family        = var.image_family
  image_name          = "${var.image_name}-${var.image_tag}"
  disk_type           = var.disk_type
#  token               = var.YC_TOKEN       # SET VIA ENV
#  folder_id           = var.YC_FOLDER_ID   # SET VIA ENV
#  zone                = var.YC_ZONE        # NOT REQUIRED, AUTO CHOICE
#  subnet_id           = var.YC_SUBNET_ID   # NOT REQUIRED, AUTO CREATING
}

build {
  sources = ["source.yandex.nginx"]
#  provisioner "shell" {
#    inline = [
#    "sudo apt update -y",
#    "python3 -m pip install --user ansible"
#    ]
#  }
  provisioner "ansible" {
    user = "ubuntu"
    keep_inventory_file = true
    ansible_env_vars = [
      ### Workaround from https://github.com/hashicorp/packer-plugin-ansible/issues/6
      "ANSIBLE_SSH_ARGS='-oHostKeyAlgorithms=+ssh-rsa -oPubkeyAcceptedKeyTypes=ssh-rsa'",
      "ANSIBLE_HOST_KEY_CHECKING=False",
#      "ANSIBLE_ROLES_PATH=./roles"
    ]
    playbook_file = "playbook.yml"
  }

}


variable "YC_FOLDER_ID" {
  type = string
  default = env("YC_FOLDER_ID")
}

variable "YC_ZONE" {
  type = string
  default = env("YC_ZONE")
}

variable "YC_SUBNET_ID" {
  type = string
  default = env("YC_SUBNET_ID")
}

variable "YC_TOKEN" {
  type = string
  default = env("YC_TOKEN")
}

variable "source_image_family" {
  type = string
  default = "ubuntu-2204-lts"
  description = "Source image family"
}

variable "ssh_username" {
  type = string
  default = "ubuntu"
  description = "SSH User"
}

variable "use_ipv4_nat" {
  type = string
  default = "true"
  description = "NAT to get external IP (true or false value)"
}

variable "image_description" {
  type = string
  default = "Yandex Cloud Ubuntu Nginx image"
  description = "Description of Packer Image"
}

variable "image_family" {
  type = string
  default = "ubuntu-nginx"
  description = "Packer image family"
}

variable "image_name" {
  type = string
  default = "nginx"
  description = "Packer image name"
}

variable "image_tag" {
  type = string
  default = "1"
  description = "Packer image tag"
}

variable "disk_type" {
  type = string
  default = "network-hdd"
  description = "Disk using template"
}