resource "yandex_compute_disk" "default" {
  count     = 3
  name      = "disk-${count.index + 1}"
  type      = "network-hdd"
  zone      = var.default_zone
  size      = 1
  folder_id = var.folder_id
  labels = {
    environment = "storage"
  }
}


resource "yandex_compute_instance" "storage" {
  name        = "storage"
  hostname    = "storage"
  platform_id = "standard-v1"

  resources {
    cores         = 2
    memory        = 2
    core_fraction = 5
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
      type     = "network-hdd"
      size     = 10
    }
  }

  metadata = local.metadata

  scheduling_policy {
    preemptible = true
  }

  network_interface {
    subnet_id          = yandex_vpc_subnet.develop.id
    nat                = true
    security_group_ids = toset([yandex_vpc_security_group.example.id])
  }

  dynamic "secondary_disk" {
    for_each = yandex_compute_disk.default
    content {
      disk_id = secondary_disk.value.id
    }
  }
  allow_stopping_for_update = true
}


