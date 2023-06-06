data "yandex_compute_image" "this" {
  name = "${var.image_name}-${var.image_tag}"
}

resource "yandex_compute_instance_group" "this" {
  name                = "${local.resource_name}-${var.instance_group_name}"
  service_account_id  = yandex_iam_service_account.this.id
  deletion_protection = false
  labels = var.labels

  instance_template {
    platform_id = local.platform_id
    labels = var.labels
    resources {
      memory = var.resources.memory
      cores  = var.resources.cpu
      core_fraction = var.resources.core_fraction
    }

    boot_disk {
      mode = "READ_WRITE"
      initialize_params {
        image_id = data.yandex_compute_image.this.id
        size     = var.resources.disk
      }

    }
    network_interface {
      network_id = yandex_vpc_network.this.id
      nat = true
    }

    metadata = {
      ssh-keys = var.public_ssh_key_path != "" ? "ubuntu:${file(var.public_ssh_key_path)}" : "yc-user:${tls_private_key.rsa_key[0].public_key_openssh}"
    }

    network_settings {
      type = "STANDARD"
    }
  }

  scale_policy {
    fixed_scale {
      size = var.scale_count
    }
  }

  allocation_policy {
    zones = var.az
  }

  deploy_policy {
    max_unavailable = 2
    max_creating    = 2
    max_expansion   = 2
    max_deleting    = 2
  }

  depends_on = [
    yandex_iam_service_account.this,
    yandex_resourcemanager_folder_iam_binding.this,
    yandex_vpc_network.this,
    yandex_vpc_subnet.this
  ]
}