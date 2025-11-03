locals {
  vms_ssh_root_key =  sensitive(file(var.vms_ssh_public_root_key))


  metadata = merge(var.metadata, {
    ssh-keys = sensitive("${var.vm_web_user}:${local.vms_ssh_root_key}")
  })


  project       = "netology"
  env           = "develop"
  system        = "platform"

  vm_web_name   = "${local.project}-${local.env}-${local.system}-web"
  vm_db_name    = "${local.project}-${local.env}-${local.system}-db"
}
