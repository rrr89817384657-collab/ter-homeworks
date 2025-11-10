locals {
  vms_ssh_root_key = sensitive(file(var.vms_ssh_public_root_key))

  metadata = {
    ssh-keys = "${var.vm_web_user}:${local.vms_ssh_root_key}"
  }
}