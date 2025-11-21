output "network_id" {
  value = yandex_vpc_network.develop.id  
}

output "subnet_id" {
  value = yandex_vpc_subnet.develop_a.id  
}

output "subnet_zone" {
  value = yandex_vpc_subnet.develop_a.zone 
}

output "subnet_details" {
  value = yandex_vpc_subnet.develop_a  
}
