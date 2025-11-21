
#создаем облачную сеть
#resource "yandex_vpc_network" "develop" {
#  name = "develop"
#}

#создаем подсеть
#resource "yandex_vpc_subnet" "develop_a" {
#  name           = "develop-ru-central1-a"
#  zone           = "ru-central1-a"
#  network_id     = yandex_vpc_network.develop.id
#  v4_cidr_blocks = ["10.0.1.0/24"]
#}

#resource "yandex_vpc_subnet" "develop_b" {
#  name           = "develop-ru-central1-b"
#  zone           = "ru-central1-b"
#  network_id     = yandex_vpc_network.develop.id
#  v4_cidr_blocks = ["10.0.2.0/24"]
#}


module "vpc_marketing" {
  source         = "./modules/vpc"  
  env_name       = "develop-ru-central1-a"
  zone           = "ru-central1-a"
  v4_cidr_blocks = "10.0.1.0/24"
}

module "vpc_analytics" {
  source         = "./modules/vpc" 
  env_name       = "develop-ru-central1-b"
  zone           = "ru-central1-b"
  v4_cidr_blocks = "10.0.2.0/24"
}

module "marketing-vm" {
  source         = "git::https://github.com/udjin10/yandex_compute_instance.git?ref=main"
  env_name       = "develop" 
  network_id     =  module.vpc_marketing.network_id 
  subnet_zones   =  [module.vpc_marketing.subnet_zone] 
  subnet_ids     =  [module.vpc_marketing.subnet_id]
  instance_name  = "marketing"
  instance_count = 1
  image_family   = "ubuntu-2004-lts"
  public_ip      = true

  labels = { 
    owner= "i.ivanov",
    project = "marketing"
     }

  metadata = {
    user-data          = data.template_file.cloudinit.rendered #Для демонстрации №3
    serial-port-enable = 1
  }

}

module "analytics-vm" {
  source         = "git::https://github.com/udjin10/yandex_compute_instance.git?ref=main"
  env_name       = "stage"
  network_id     = module.vpc_analytics.network_id 
  subnet_zones   = [module.vpc_analytics.subnet_zone] 
  subnet_ids     = [module.vpc_analytics.subnet_id]
  instance_name  = "analytics"
  instance_count = 1
  image_family   = "ubuntu-2004-lts"
  public_ip      = true

  labels = { 
    owner   = "i.ivanov",
    project = "analytics" 
     }

  metadata = {
    user-data          = data.template_file.cloudinit.rendered #Для демонстрации №3
    serial-port-enable = 1
  }

}

#Пример передачи cloud-config в ВМ для демонстрации №3
data "template_file" "cloudinit" {
  template = file("./cloud-init.yml")
  vars = {
    ssh_key = var.vms_ssh_root_key
  }
}


