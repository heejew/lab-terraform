variable "image_tag" {
  type = string
}

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
  use_ipv4_nat        = var.use_ipv4
  image_description   = var.image_description
  image_family        = var.image_family
  image_name          = "${var.image_name}-${var.image_tag}"
  disk_type           = var.disk_type

  token               = var.YC_TOKEN
  folder_id           = var.YC_FOLDER_ID
  zone                = var.YC_ZONE
  subnet_id           = var.YC_SUBNET_ID
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
