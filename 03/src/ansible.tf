resource "local_file" "hosts_templatefile" {
  content = templatefile("${path.module}/hosts.tftpl",{
    web = yandex_compute_instance.web
    db  = [for k, v in yandex_compute_instance.db : v] 
    storage    = [yandex_compute_instance.storage]         
  })
  filename = "${abspath(path.module)}/hosts.ini"
}