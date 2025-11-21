output "marketing_vm_fqdn" {
  value = module.marketing-vm.fqdn
}

output "analytics_vm_fqdn" {
  value = module.analytics-vm.fqdn
}

output "all_vm_fqdns" {
  value = concat(module.marketing-vm.fqdn, module.analytics-vm.fqdn)
}