cloud_id          = "b1gnfsvvvrkpvs34a"  
folder_id         = "b1gdtdsm3gtnu18d7"  
default_zone      = "ru-central1-a"         

vms_ssh_public_root_key = "~/.ssh/yandex_vm_rsa.pub"


vms_resources = {
  web = {
    cores         = 2
    memory        = 2
    core_fraction = 5
  }
  db = {
    cores         = 2
    memory        = 2
    core_fraction = 20
  }
}

metadata = {
  serial-port-enable = 1
}
