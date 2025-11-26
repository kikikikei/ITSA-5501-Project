output "resource_group_id" {
  description = "ID of the resource group"
  value       = azurerm_resource_group.rg.id
}

output "vm_public_ip" {
  description = "Public IP address of the VM"
  value       = azurerm_public_ip.pip.ip_address
}

output "vm_id" {
  description = "ID of the Linux VM"
  value       = azurerm_linux_virtual_machine.vm.id
}
